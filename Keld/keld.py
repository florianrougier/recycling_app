import os
import matplotlib.pyplot as plt
import matplotlib.image as mpimg

# We now define where our classes are located

training_dir = './data'
validation_dir = './vali'
test_dir = './test'

#We now define a plot_images function, to allow us to view multiple images at once. Please note, that the function takes a path as argument, so that we can easily plot various cases.

def plot_images(path, labeled=False, max_images=6):
  amount = 0
  fig = plt.figure(figsize=(12, 6))

  for file in os.listdir(path):
    if file.endswith('.jpeg'):
      if amount == max_images:
        break

      img = mpimg.imread(os.path.join(path, file))
      plt.subplot(231+amount)
      if labeled:
        plt.title(file.split('_')[1])
      imgplot = plt.imshow(img)

      amount += 1

#we now view some images that should be sorted as trash

plot_images(training_dir + '/trash')
