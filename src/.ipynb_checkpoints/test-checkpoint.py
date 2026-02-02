# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---
# %%

import os
import skimage as ski

images = []
for i in range(25):
    image = ski.io.imread(f"{os.getcwd()}/images/{i}.png")
    images.append(image)
print(images)

# %% 
from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
from scipy import ndimage

# %%

# 6 x 5
fig, axes = plt.subplots(6, 5, figsize=(12, 8))
axes = axes.flatten()

for idx, ax in enumerate(axes):
    if idx < len(images):

        image = images[idx]
        image = ski.color.rgb2gray(image)
        edges = ski.feature.canny(image)


        ax.imshow(edges, cmap='gray')
        ax.set_title(f"Image-{idx}")
    ax.axis('off')
plt.tight_layout()
plt.show()


# %%
fig, axes = plt.subplots(6, 5, figsize=(12, 8))
axes = axes.flatten()

for idx, ax in enumerate(axes):
    if idx < len(images):

        image = images[idx]
        image = ski.color.rgb2gray(image)
        edges = ski.feature.canny(image)
        edges = ndimage.laplace(edges)


        ax.imshow(edges, cmap='gray')
        ax.set_title(f"Image-{idx}")
    ax.axis('off')
plt.tight_layout()
plt.show()

# %% IMAGES
fig, axes = plt.subplots(6, 5, figsize=(12, 8))
axes = axes.flatten()

for idx, ax in enumerate(axes):
    if idx < len(images):

        image = images[idx]
        image = ski.color.rgb2gray(image)
        #edges = ski.feature.canny(image)
        edges = ndimage.prewitt(image)


        ax.imshow(edges, cmap='gray')
        ax.set_title(f"Image-{idx}")
    ax.axis('off')
plt.tight_layout()
plt.show()



























