Tutorial
========

1. The data file, which will be provided, should be called data.csv. The path is
hard-coded and so the data file should reside in the the same directory as all
the .pde files associated with this project.

2. Upon running the visualization the first screen that will be visible is a
group of circles laid out vertically along a scale on the left side of the
canvas. The circles represent error categories which were pre-processed out of
the COMP 40 dataset(s). The size of the circles indicate the number of students
associated with that error category. The vertical orientation signifies the
estimated grade given the error category. The scale specifies the range of
grades going from the highest estimated grade at the top to the lowest estimated
grade at the bottom.

Clicking on a circle will bring up a list of students associated with the error
category on the right side. The visualization on the right side shows the student
names along with a segmented bar associated with each student. The segments
represent all the error categories that the particular student encountered. The
width of each bar segment represents the percentage of tests that the error
category appeared in for that particular student. The error category that was
just selected using the circle is highlighted across all students. The green bar
segment at the end of at least some of the bars indicates the percentage of
tests that the student passed.

Hovering over any of the bar segments will show the name of the error category.
Clicking on an error segment will select the associated circle on the left side
and will bring up a new list of students on the right side of the canvas if
another error category was chosen.

If the list of students for an error category is too large, pagination is
available. Please notice the pagination controls on the bottom of the list of
students to traverse through the entire list of students if it cannot fit on one
page.
