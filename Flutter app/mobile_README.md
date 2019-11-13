# Recycling app - Mobile version

> This is the mobile version (only for Android at the moment) of our recycling app

Minimum Viable Product (MVP) that represents how to create a mobile app that implements machine learning and can be used to classify waste. This basic project can be extended by adding more classes, i.e. organic waste, different types of plastic, and by giving to final users correct info on how to differentiate waste based on their location, by integrating regional policies for waste management. Moreover one can imagine to use machine learning to identify product EAN code and get from producers instructions about packaging recycling.

## Table of Contents

- [Installation](#installation)
- [Demo](#demo)
- [Features](#features)
- [Contributing](#contributing)
- [Team](#team)
- [FAQ](#faq)
- [License](#license)

---

## Installation

1. Please download the apk [here](todo) and enjoy!

---

## Demo

 [Watch a demo on youtube](http://i3.ytimg.com/vi/RdQVJcON6OI/maxresdefault.jpg)(https://youtu.be/RdQVJcON6OI) 

---

## Features

This application is a fine-tuned CNN classifier built with [fast.ai](https://docs.fast.ai/) converted to a fully compliant [PyTorch mobile framework](https://pytorch.org/mobile/home/) and then delivered through a [flutter](https://flutter.dev/) app 

Its features:

1. base model: [resnet34](https://www.kaggle.com/pytorch/resnet34) CNN 
2. transfer learning accomplished on [Trashnet](https://github.com/garythung/trashnet) dataset
3. parameter fine-tuning of the whole model with appropriate learning rate (final error rate = 5%)
4. model converted to PyTorch mobile
5. development of a basic flutter application that interacts with Android camera to take screenshot and then give prediction through ML

---

## Contributing

Feel free to contribute to our code.

---

## Team 

[![road2AGI](https://avatars0.githubusercontent.com/u/29116904?s=200&v=4)](https://github.com/florianrougier)
[![angelinux](https://avatars3.githubusercontent.com/u/1552481?s=200&v=4)](https://github.com/angelinux)
[![kimutai](https://avatars2.githubusercontent.com/u/47734618?s=200&v=4)](https://github.com/marchemjor) 
<a href="https://github.com/Keld-j" ><img src="https://avatars2.githubusercontent.com/u/54741534" alt="Keld" width="200"></a>

---

## FAQ

No FAQ here at the moment


---

## License

Available [here](../LICENSE)
