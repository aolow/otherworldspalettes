#!/usr/bin/env python3
"""Generate experimental Galaxy 40 palettes.

Optional design dependencies (not R package dependencies):
    pip install numpy scipy scikit-image

Deterministic seed, sRGB candidate pool, approximate Machado-matrix color-vision
simulations. Screening is not a perceptual accessibility guarantee.
Run from any directory: python design/galaxy40/generate.py
Outputs go beside this script and may be compared to R/palettes.R.
"""
from pathlib import Path
import json
import numpy as np
from scipy.spatial.distance import cdist
from skimage.color import rgb2lab, deltaE_ciede2000

SEED = 20261017
rng = np.random.default_rng(SEED)
COSMIC = [
    "#009E91","#BE2E4A","#9ED9E5","#F4C430","#60758C","#F58231",
    "#4E91D8","#7A8B22","#C13C91","#00A65A","#A68AD5","#A7C636",
    "#1859A9","#8C5A3C","#8046B2","#F3D9A2","#25314F","#D5A267",
    "#00B9D8","#D94330",
]
MACHADO = {
    "protan": np.array([
        [.152286,1.052583,-.204868],
        [.114503,.786281,.099216],
        [-.003882,-.048116,1.051998]]),
    "deutan": np.array([
        [.367322,.860646,-.227968],
        [.280085,.672501,.047413],
        [-.011820,.042940,.968881]]),
}
def to_rgb(h):
    return np.array([int(h[i:i+2],16)/255 for i in (1,3,5)])
def to_hex(a):
    return "#" + "".join(f"{v:02X}" for v in np.round(np.clip(a,0,1)*255).astype(int))
def linearize(a):
    return np.where(a<=.04045,a/12.92,((a+.055)/1.055)**2.4)
def delinearize(a):
    return np.where(a<=.0031308,12.92*a,1.055*np.maximum(a,0)**(1/2.4)-.055)
def cvd(rgb, which, severity=.65):
    linear=linearize(rgb)
    simulated=np.clip(linear@MACHADO[which].T,0,1)
    return np.clip(delinearize((1-severity)*linear+severity*simulated),0,1)
def lab_views(rgb):
    return [rgb2lab(rgb[None,:,:])[0]]+[
        rgb2lab(cvd(rgb,mode)[None,:,:])[0] for mode in MACHADO]
def contrast(rgb):
    y=linearize(rgb)@np.array([.2126,.7152,.0722])
    return 1.05/(y+.05), (y+.05)/.05

def pool():
    raw=np.concatenate([
        rng.random((45000,3)),
        rng.choice(np.linspace(0,1,17),size=(16000,3))],axis=0)
    rgb=np.round(raw*255).astype(np.uint8).astype(float)/255
    lab=rgb2lab(rgb[None,:,:])[0]
    chroma=np.sqrt(lab[:,1]**2+lab[:,2]**2)
    w,b=contrast(rgb)
    keep=(lab[:,0]>=29)&(lab[:,0]<=80)&(chroma>=22)&(w>=2.25)&(b>=2.2)
    rgb=np.unique((rgb[keep]*255).astype(np.uint8),axis=0).astype(float)/255
    return rgb[::2]

candidates=pool()
views=lab_views(candidates)
original_rgb=np.stack([to_rgb(s) for s in COSMIC])
original_views=lab_views(original_rgb)
distance_from_art=cdist(views[0],original_views[0]).min(axis=1)
bonus=.70*np.exp(-distance_from_art/22.0)

def score_to_one(point):
    ds=[deltaE_ciede2000(x,p[None,:]) for x,p in zip(views,point)]
    return np.minimum(ds[0],np.minimum(ds[1]*1.30,ds[2]*1.30))

def greedily_select(prefix=False,start=None):
    indices=[]
    chosen=[] if not prefix else [v for v in np.stack(original_views,axis=1)]
    min_dist=np.full(len(candidates),np.inf)
    for p in chosen:
        min_dist=np.minimum(min_dist,score_to_one(p))
    if start is None and not chosen:
        start=int(np.argmax(bonus+2*np.sin(views[0][:,1]/30)))
    if start is not None:
        indices.append(start)
        min_dist=np.minimum(min_dist,score_to_one([v[start] for v in views]))
    while len(chosen)+len(indices)<40:
        score=min_dist+bonus*.40
        if indices: score[np.asarray(indices)]=-np.inf
        i=int(np.argmax(score))
        indices.append(i)
        min_dist=np.minimum(min_dist,score_to_one([v[i] for v in views]))
    return np.vstack([original_rgb,candidates[indices]]) if prefix else candidates[indices]

def combined_min(rgb):
    labs=lab_views(rgb)
    ds=[deltaE_ciede2000(x[:,None,:],x[None,:,:]) for x in labs]
    score=np.minimum(ds[0],np.minimum(1.30*ds[1],1.30*ds[2]))
    np.fill_diagonal(score,np.inf)
    return float(np.min(score))

compatible=greedily_select(prefix=True)
choices=[greedily_select(start=s) for s in
         [None,200,1000,2000,4000,6000,9000,12000]]
optimized=max(choices,key=combined_min)
out=Path(__file__).resolve().parent
for name,colors in [("galaxy40",compatible),("galaxy40_max",optimized)]:
    hexes=[to_hex(x) for x in colors]
    (out/(name+".json")).write_text(json.dumps(hexes,indent=2)+"\n")
    print(name,"min combined CIEDE2000 proxy",round(combined_min(colors),2))
    print(name,"colors",hexes)
