# TMTTabBar [![Build Status](https://travis-ci.org/TobiasMende/TMTTabBar.svg?branch=master)](https://travis-ci.org/TobiasMende/TMTTabBar)

TMTTabBar is an implementation of a tab bar view. It is meant as library for OS X development.
At the current stage, OS X 10.11 is required. This may change in the future.

## Features

The following list is not complete:

* Add tabs
* Close tabs
* Switch tabs
* Move tabs inside the tab bar
* Drag tabs to other tab views
* Drag tabs to new windows
* The tab selection order is remembered, such that closing a tab will automatically select the previously selected tab

## Usage

The tab bar was developed, having reusability and customizability in mind.
Therefore, almost any aspect of the views can be customized by implementing the `TMTTabViewDelegate` protocol.

See the TMTTabBarDemo project for usage examples. This project uses the `TMTTabbedWindow` for displaying tabs. This window controller and its window come with the library and can be used very easily.
However, you can build custom tab views, by using the following components:

* `TMTTabBarView` is the view, which contains the tabs
* `TMTTabViewContainerView` is the view which contains the view that belongs to the selected tab
