# Keys to our study of CSS

1. crucial to know exactly how styles are rendered. Specifically,
we’ll need to know how different types of selectors work and how the order
of those selectors can affect how our styles are rendered.

2. We’ll also want to understand a few common property values that continually
appear within CSS, particularly those that deal with color and length.

# In CSS, all styles cascade from top of a style sheet to the bottom.
Ex: suppose all paragraphs at the top of the style sheet are set to a background
and font-size. Then, towards bottom of our style sheet, it is set to green.

p {
  background: orange;
  font-size: 24px;
}
p {
  background: green;
}

# CSS will now set the paragraph selector to green since it comes after (last)
# the font size however will remain as 24px

########################## CASCADING PROPERTIES ##########################
# when we set a selector to two values within same selector, it is the same
# as previous, meaning the last selector will be set accordingly.

p {
  background: orange;
  background: green;
}

########################## CALCULATING SPECIFICITY ##########################
- every selector in CSS has a specified weight. A selectors weight, along with
  its placement in the cascade, identifies how its styles will be rendered.

# Recall: 3 types of selectors: type, class, ID.

# Type: lowest weight and holds a point value of 0-0-1
# Class: medium weight and holds a point value of 0-1-0
# ID: high weight and holds a point value of 1-0-0

Notice the specificity points are calculated using 3 columns.

The higher the specificity weight of a selector, the more superiority the
selector is given when a styling conflict occurs.

Ex: paragraph element is selected using a type selector in one place and an
    ID selector in another. In this case, ID selector will take precedence over
    the type selector, regardless of where ID selector appears in cascade.

# HTML
<p id="food">...</p>

# CSS
#food {
  background: green;
}
p {
  background: orange;
}

# paragraph element with an id attribute value of food.


############################ COMBINING SELECTORS ############################

we can in fact combine selectors and be more specific about which element
or group we are selecting.

Ex: select all paragraphs that reside within an element with a class attribute
    value of hotdog.
    however, if one of those paragraphs happens to have the class attribute value
    of mustard, we want it to be different.

# HTML
<div class="hotdog">
  <p>...</p>
  <p>...</p>
  <p class="mustard">...</p>
</div>

# CSS
.hotdog p {
  background: brown;
}
.hotdog p.mustard {
  background: yellow;
}

Note: when combining, selectors should be read right to left.

# KEY SELECTOR: directly before the curly bracket

selector: .hotdog p
two selectors: - class and type selector.
               - separated by single space.
               - key selector: type selector (p)
               - so this will only select paragraph elements that reside within
                   an element with a class attribute value of hotdog

selector: .hotdog p.mustard
three selectors: - two class selectors and one type selector.
                 - notice the p.mustard
                 - key selector: class selector mustard
                 - all individual selectors coming before it are now prequalifies


##################### SPECIFITY WITH COMBINED SELECTORS #######################

# Recall: 3 types of selectors: type, class, ID.

# Type: lowest weight and holds a point value of 0-0-1
# Class: medium weight and holds a point value of 0-1-0
# ID: high weight and holds a point value of 1-0-0

In our previous example, we had:

.hotdog p             # one class and one type selector
# value: 0-1-1

.hotdog p.mustard     # two class and one type selector
# value: 0-2-1

Comparing the two selectors, the second selector, with its two classes, has a
noticeably higher specificity weight and point value. As such it will take
precedence within the cascade. If we were to flip the order of these selectors
within our style sheet, placing the higher-weighted selector above the
lower-weighted selector as shown here, the appearance of their styles would
not be affected due to each selector’s specificity weight.

.hotdog p.mustard {
  background: yellow;
}
.hotdog p {
  background: brown;
}

#############################################################################
################## Layering Styles with Multiple Classes ####################
#############################################################################

Elements within HTML can have more than one class attribute value so long as
each value is space separated. With that, we can place certain styles on all
elements of one sort while placing other styles only on specific elements of
that sort.

ex: buttons. Say we want all of our buttons to have a font size of 16 pixels,
    but we want the background color of our buttons to vary depending on where
    the buttons are used.

# HTML
<a class="btn btn-danger">...</a>
<a class="btn btn-success">...</a>

# CSS
.btn {
  font-size: 16px;
}
.btn-danger {
  background: red;
}
.btn-success {
  background: green;
}

two anchor elements, both with multiple class attribute values.
The first class, btn, is used to apply a font size of 16 pixels to each of the
elements. Then, first anchor element uses an additional class of btn-danger
to apply a red background color while the second anchor element uses an
additional class of btn-success to apply a green background color. Our
styles here are clean and modular.

#############################################################################
####################### COMMON CSS PROPERTY VALUES #########################
#############################################################################


################################# COLORS #################################


- CSS colors are defined on an sRGB
- 4 primary ways to represent sRGB :  1. keywords
                                      2. hexadecimal notation
                                      3. RGB values
                                      4. HSL values

1. Keywords
ie: black, green, red, blue

https://www.w3.org/TR/css3-color/#html4

# CSS
.task {
  background: maroon;
}
.count {
  background: yellow;
}


2. hexadecimal notation

# consist of # (pound or hash) followed by 3-6 character figures
# figures: 0-9
# letters: a-f in upper or lower case

in six-character notation: first 2 = red, second 2 = green, last 2 = blue
in three-char notation: first char = red, second char = green, last char = blue

in six-char: if first two chars are equal, then each consecutive pair is equal.
             this also means you can shorten it to three-char notation.

ex: #ff6600 can equal #f60

# CSS
.task {
  background: #800000;
}
.count {
  background: #ff0;
}

# Adobe Color Wheel
https://color.adobe.com/create/color-wheel/?base=2&rule=Shades&selected=3&name=My%20Color%20Theme&mode=rgb&rgbvalues=0.5647058823529412,0.75,0.6420580352324177,0.3764705882352941,0.5,0.4280386901549451,0.7529411764705882,1,0.8560773803098902,0.18823529411764706,0.25,0.21401934507747455,0.6776470588235294,0.9,0.7704696422789012&swatchOrder=0,1,2,3,4


3. RGB & RGBa Colors

rgb() function
The function accepts three comma-separated values, each of which is an integer from 0 to 255

rgb(red, green, blue)

# CSS
.task {
  background: rgb(128, 0, 0);
}
.count {
  background: rgb(255, 255, 0);
}

RGB color values may also include an alpha, or transparency, channel by using
  the rgba() function
The rgba() function requires a fourth value, which must be a number between 0
  and 1, including decimals.


ex: shade of orange to be 50% opaque
rgba(255, 102, 0, .5)

Change the opacity of our maroon and yellow background colors.
The following code sets the maroon background color to 25% opaque and leaves
the yellow background color 100% opaque.

# CSS
.task {
  background: rgba(128, 0, 0, .25);
}
.count {
  background: rgba(255, 255, 0, 1);
}


4. HSL & HSLa Colors

hsl() function, which stands for hue, saturation, and lightness.

first value:  hue
              is a unitless number from 0 to 360. The numbers 0 through
              360 represent the color wheel, and the value identifies the
              degree of a color on the color wheel.

second value: saturation, percentage values from 0 to 100.
                saturation value identifies how saturated with color the hue is,
                with 0 being grayscale and 100% being fully saturated

third value: lightness, percentage values from 0 to 100.
                how dark or light the hue value is, with 0 being completely
                black and 100% being completely white.

ex: shade of orange
# hsl(24, 100%, 50%)

maroon and yellow background examples

# CSS

# .task {
#   background: hsl(0, 100%, 25%);
# }
# .count {
#   background: hsl(60, 100%, 50%);
# }

hsla() function: includes an alpha or transparency channel
  value between 0 and 1, including decimals, must be added to function to identify
  the degree of opacity.

ex: shade of orange as an HSLa color set to 50% opaque would be represented as
# hsla(24, 100%, 50%, .5)

################### BEST CHOICE?

For the time being, hexadecimal color values remain the most popular as they
are widely supported; though when an alpha channel for transparency is needed,
RGBa color values are preferred. These preferences may change in the future,
but for now we’ll use hexadecimal and RGBa color values.

############################### LENGTHS ###############################

Absolute and relative. Each uses different units of measurements.

################### ABSOLUTE LENGTHS ###################

- simplest length values, as they are fixed to a physical measurement such as
  inches, centimeters, millimeters.

- most popular: pixel

################### PIXELS

- pixel is equal to 1/96th of an inch; thus there are 96 pixels in an inch

# CSS ex:
p {
  font-size: 14px;
}

################### RELATIVE LENGTHS ###################


- most popular: percentages

################### PERCENTAGES

Percentage lengths are defined in relation to the length of another object.
For example, to set the width of an element to 50%, we have to know the width of its parent element,

# CSS ex:
# .col {
#   width: 50%;
# }

Here we’ve set the width of the element with the class attribute value of col
to 50%. That 50% will be calculated relative to the width of the element’s parent.

################### EM

length is calculated based on an element’s font size.

single em unit is equivalent to element’s font size.
Example: element has a font size of 14 pixels and a width set to 5em,
         the width would equal 70 pixels (14 pixels multiplied by 5)

# CSS
.banner {
  font-size: 14px;
  width: 5em;
}

When a font size is not explicitly stated for an element, the em unit will be
  relative to the font size of the closest parent element with a stated font size.

Use: em unit is used for styling text: font sizes, and spacing around text, including margins and paddings.


Summary
Sadly our Styles Conference website lay dormant this lesson. We focused on the
   foundations of CSS, covering exactly how it works and some common values we’re sure to use.

To briefly recap, within this lesson we’ve discussed the following:

- How style sheets cascade from the top to the bottom of a file
- What specificity is and how we can calculate it
- How to combine selectors to target specific elements or groups of elements
- How to use multiple classes on a single element to layer on different styles for more modular code
- The different color values available to use within CSS, including keyword, hexadecimal, RGB, and HSL values
- The different length values available to use within CSS, including pixels, percentages, and em units
