---

---

**Correlation analysis** is a key task when you're exploring any dataset. The principal objective is to find linear relationships between features that can help to understanding the big picture.

Probably, the best way to see correlations between variables is to use scatterplots, but in most of time you're working with a high dimensional dataset with a high number of variables, in these situations you have two major problems:

-   It's a high computational task to plot lots of scatterplot, specially if you have a big dataset.
-   Even if you can plot all scatterplots at once, the readability of the charts will be horrible, and you'll not see nothing useful.

One great approach to solve this problem is calculating the coefficient of correlation and instead of having lots of scatterplots, you'll have a matrix showing how much it correlates your variables, assuming a range from -1 to 1, high negatively correlated to high positively correlated, respectively. This is definitely much faster to plot and easy to interpret.

### Misinterpretation of the coefficient of correlation

Before starting to code, it's important to understand two topics about correlation analysis to drift reliable conclusions.

#### First point

Sometimes, we misinterpret the value of coefficient of correlation and establish the cause-and-effect relationship, i.e. one variable causing the variation in the other variable. Actually, we cannot interpret in this way unless we have a powerful motive beside just the coefficient value.

Correlation coefficient gives us a quantitative determination of a relationship between two variables X and Y, not information about the association between the two variables. Causation implies an invariable sequence --- A always leads to B --- whereas correlation is a measure of mutual association between two variables.

[figure correlation and causation]

#### Second point

Another aspect that we need to be aware of is the factors that influencing the size of the correlation coefficient and can also lead to misinterpretation, like:

-   The size of the coefficient is very much dependent upon the variability of measured values in the correlated sample. The greater the variability, the higher will be the correlation, everything else being equal.
-   The size of the coefficient is altered when an investigator selects an extreme group of subjects to compare these groups regarding certain behavior. The coefficient got from the combined data of extreme groups would be larger than the coefficient got from a random sample of the same group.
-   Addition or dropping the extreme cases from the group can lead to a change in the coefficient's size. Addition of the extreme case may increase the size of correlation, while dropping the extreme cases will lower the value of the coefficient.

With that in mind, it's a good idea to do a standardized step before looking for correlations, to minimize variability and extreme values.

### How to do a correlation analysis in R?

As everything in R, here there are also plenty packages to calculate and plot coefficients of correlation. It's up to you to choose which package is better for your analysis.

The aim of this article is to help you structure a optimized workflow for correlation analysis, creating great charts and consistent functions. For that will be necessary, especially two specific packages, corrplot and corrr.

### Data

As a dataset for this tutorial, I'll use some data from a personal project in development. I collected the data from a public API and from an electronic game called League of Legends.

*League of Legends* is one of the most popular video games in the world. It is played by over 100 million active users every single month. Each team has a base they must guard from their opponents while simultaneously attacking their opponent's base, there is the Blue team, whose base is in the lower left part of the map, and the Red team, whose base is in the upper right part of the map, at the back of each team's base there is a building called The Nexus. You win the game by destroying the enemy team's Nexus.

During the match, there are a lot of statistics about performing each player (5 in each team) and also from the match itself, so, I created a script to collect all this information.

The game also has a ranking by country and according to your performance you get a specific tier, that can be: iron, bronze, silver, gold, platinum, diamond, master, grandmaster and challenger, following the batter to worse order, respectively.

Just to simplify the example, I'll show just the data for one particular tier of users, diamond players.

I choose this dataset because we have a lot of variables, high dimensionality, and look for linear correlations can be useful to build our model in the next stage of the project.

I cleaned the dataset before, and the script used for that is in my GitHub repo. Besides that, you can find the description of the variables used here on this kaggle kernel created by me. If you have any questions, please let me know.

### Using corplot package

This is a well-known library, that R users normally choose. The downside from corplot package is we don't have a ggplot object at the output, and because of that is difficult to customize the plot with something that you want.

But the procedure to plot the correlation coefficients using corplot is fairly simple:

1.  calculate the correlation matrix
2.  apply the corrplot() function
3.  customize

Although the simplicity of this process, the final result it's not so beautiful and it's not the best chart to put in your report.

One feature that most people don't know is the possibility to group variables, creating clusters regarding the correlation coefficient. Definitely this can improve the visualization and interpretability of the result.

In the following sequence of steps I'll show you how to improve the final result:

1.  Change the method parameter to put a square shape in the circle place (more easy to read). This way we can get the second plot.

2.  But as a personal taste I don't like the grid, and so I change from square to color (third plot).

3.  Here we have a problem, as a correlation matrix is mirrored, you end up with too much information to analyze. To solve that, we take just the inferior triangle and get the plot 4.

4.  We can agree that red text is not the better color to put in your chart, for that we can change tl.col to black and also decrease the font size with tl.cex (plot 5).

5.  And the most important, we can rearrange the variables using clustering methods, the corrplot function accept 5 different ways: AOE, FPC, hclust and alphabet (look the documentation to see more).

Look that this plot really helps you see distinct groups of variables that have similar correlations, and can be a start point to investigate specific groups later.

### Using corrr package

This second approach is the most tidy way to perform a correlation analysis. To facilitate the readability of this workflow, I drew this flowchart below:

![](correlation_07.png)

It's incredibly straightforward, and you just need to tune specific parameters to achieve a astonish chart. The standard configuration is shown in the next figure:

Yes, it's a mess and difficult to read. Let's improve this plot following some customizations:

1.  Set the PCA method for rearrange the variables.

2.  Setting shape = 15, will put squares shape in circle places. You can also try different number to different shapes.

3.  I'll choose better colors. And at the end, I will set the x-axis label angle to 45 and hjust = 1, to put the axis text in right place.

The corrr library can also use a lot of different clustering methods for rearranging the variables, and you can get the full list from the seriate package documentation.

One more convenience in use corrr is that you can create plotly interactive plots and hover through specific squares to investigate the values of correlation coefficients and the variable in x and y axis (play the video).

Now that you already have a fully understanding in how to plot a good chart to investigate the correlation between your variables, I'll show you one specific approach to a more applicable task in your modeling workflow.

See, the correlation between all variables is useful, but as we are investigating a correlation against one specific variable (target), a better way is to extract the correlation coefficients to that specific variable and plot it.

### Creating the plot\_cor() function

In this last section, I'll show you two functions you can use to create beautiful plots and see which variable can contribute more to your correlation analysis.

First, we need the get\_cor() function, that will return the correlation matrix. After, we plug into plot\_cor() function and get our awesome chart.

Second, we need the plot function.

And that is the final result. Look, you can change the target variable and see the correlation between other variables too, just need to change the target parameter. I encourage you to explore different customizations and change the default values for this function, and if you find any question, please let me know.

I hope you enjoyed this tutorial, bye! \^\^

LinkedIn:

GitHub:

source:
