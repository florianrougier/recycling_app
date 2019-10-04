[ ![Recycling](http://sites.psu.edu/aspsy/wp-content/uploads/sites/8070/2014/11/recycle.jpg)](http://herokuapp)

# Recycling app - MMWML

> Produce a recycling app based on image classifier

> Our aim is to help people differentiate waste based on its appearance

> deep learning, classifier, transfer learning, waste disposal

[![my badger](https://img.shields.io/badge/mybadger-whatever&nbsp;you&nbsp;want-brightgreen)](http://badges.github.io/badgerbadgerbadger/)

[![First approach to recycling](https://i.pinimg.com/736x/57/4b/a4/574ba4df89498ac8a705119b575eb7c7.jpg)]()

How it works?

[![How it works](http://g.recordit.co/0SFAppGQti.gif)]()

---

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

1. Install Docker
2. Run ```  docker build -t recycling_app:latest . ``` to build your image
3. Execute ``` docker run -d -p 5000:5000 recycling_app ```
4. Go to your browser [http://127.0.0.1:5000/](http://127.0.0.1:5000/) and enjoy!

---

## Demo

A demo is available on [https://trash-classifier-ai.herokuapp.com](https://trash-classifier-ai.herokuapp.com)

---

## Features

This application is a fine-tuned CNN classifier built with [fast.ai](https://docs.fast.ai/) and provided by a [Flaskex](https://github.com/anfederico/Flaskex) framework.
Its features:

1. base model: [resnet34](https://www.kaggle.com/pytorch/resnet34) CNN 
2. transfer learning accomplished on [Trashnet](https://github.com/garythung/trashnet) dataset with glass, c
3. parameter fine-tuning of the whole model with appropriate learning rate (final error rate = 6%)
4. model served through a Flask framework named Flaskex

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


