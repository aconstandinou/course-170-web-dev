####################### HTML #######################

# ELEMENTS

Elements are designators that define the structure and content
of objects within a page.
Ex: multiple levels of headings (identified as
<h1> through <h6> elements) and paragraphs (identified as
the <p> element); the list goes on to include the <a>,
<div>, <span>, <strong>, and <em> elements, and many more.

Elements are identified by the use of less-than and
greater-than angle brackets, < >, surrounding the
element name. Thus, an element will look like the following:

<a>

# TAGS open tag: < >  closing tag </ >
The use of less-than and greater-than angle brackets
surrounding an element creates what is known as a tag.
Tags most commonly occur in pairs of opening and closing
tags.

An opening tag marks the beginning of an element.
for example, <div>

A closing tag marks the end of an element.
for example, </div>.

The content that falls between the opening and closing
tags is the content of that element.
Anchor link: will have an opening tag of <a> and a
closing tag of </a>.
Content of Anchor Link: What falls between these two
tags <a> and </a> will be the content of the anchor link.

So, anchor tags will look a bit like this:

<a>content goes here</a>

# ATTRIBUTES
Properties used to provide additional info about
an element.
Ex: id attribute which identifies an element
Ex: class attribute which classifies an element
Ex: src attribute specifies a sourced for embeddable content
Ex: href attribute provides hyperlink ref to linked resource

An <a> element including an href attribute:
<a href="http://shayhowe.com/">Shay Howe</a>



Element  Attribute                      Tag
<a href="http://shayhowe.com">Shay Howe</a>


# HTML structure
# Must include following declaration + elements:
<!DOCTYPE html>, <html>, <head>, and <body>

<!DOCTYPE html>: informs web browsers which version of html
                is being used and is placed at beginning of HTML doc.

#<html>
Inside html element, element <head> identifies top of document
including metadata. Content inside <head> element is not displayed
on web page itself (its displayed in tab name of page).

#<body>
This is what is visible to web page.

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Hello World</title>
  </head>
  <body>
    <h1>Hello World</h1>
    <p>This is a web page.</p>
  </body>
</html>


The preceding code shows the document beginning with the document
type declaration, <!DOCTYPE html>, followed directly by the <html>
element. Inside the <html> element come the <head> and <body> elements.
The <head> element includes the character encoding of the page via the
<meta charset="utf-8"> tag and the title of the document via the <title>
element. The <body> element includes a heading via the <h1> element and
a paragraph via the <p> element. Because both the heading and paragraph
are nested within the <body> element, they are visible on the web page.

# Code Validation
# HTML
https://validator.w3.org/

# CSS
http://jigsaw.w3.org/css-validator/


####################### CSS #######################


# SELECTORS
As elements are added to a web page, they may be styled with CSS.
Selector: designates exactly which element or elements within
          our HTML to target and apply styles (color, size, position)

Typically target an attribute value such as id or class, or target type of element
such as <h1> or <p>

Within, CSS, selectors are followed by curly brackets.

p {

}

# PROPERTIES
Once element is selected, property determines the styles that will be applied.
Property names fall after a selector, within curly brackets { } and immediately
preceding a colon ;

p {
  color: ...;
  font-size: ...;
}

# VALUES

Now we can determine the behavior of that property with a value. Values can
identified as the text between the colon : and semicolon ;
Ex: selecting <p> elements

p {
  color: orange;
  font-size: 16px;
}

# Review
# Selector
p {       #value
  color: orange;
  font-size: 16px;
  #property
}
############################## CSS Selector Types
# Type Selectors
Type selectors target elements by their type.
Ex: all diviion elements <div>

# Class Selectors

Allow us to select an element based on elements class attribue value.
More specific than type selectors, as they select a group.
These are denoted with a leading period .
Ex:

#CSS
.awesome { ... }
# HTML
<div class="awesome">...</div>
<p class="awesome">...</p>


# ID Selectors

More precise than class selectors as they target only one unique element at a time.
Id attribute values can only be used once per page.
Denoted with leading hash sign #

#CSS
#shayhowe { ... }
#HTML
<div id="shayhowe">...</div>


# Additional Selectors
https://learn.shayhowe.com/advanced-html-css/complex-selectors/


####################### REFERENCING CSS IN HTML #############################
referenced from within the <head> element of our HTML
<head>
  <link rel="stylesheet" href="main.css">
</head>

If our CSS file is in a different folder, ie: stylesheets
the href attribute value would be stylesheets/main.css

<head>
  <link rel="stylesheet" href="stylesheets/main.css">
</head>
############################## CSS RESETS ##################################

Every web browser has its own default styles for different elements.
How Google Chrome renders headings, paragraphs, lists, and so forth may be
different from how Internet Explorer does. To ensure cross-browser
compatibility, CSS resets have become widely used.

There are a bunch of different resets available to use, all of which have
their own fortes. One of the most popular resets is Eric Meyer’s reset,
which has been adapted to include styles for the new HTML5 elements.

=begin
/* http://meyerweb.com/eric/tools/css/reset/ 2. v2.0 | 20110126
  License: none (public domain)
*/

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed,
figure, figcaption, footer, header, hgroup,
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure,
footer, header, hgroup, menu, nav, section {
  display: block;
}
body {
  line-height: 1;
}
ol, ul {
  list-style: none;
}
blockquote, q {
  quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
  content: '';
  content: none;
}
table {
  border-collapse: collapse;
  border-spacing: 0;
}

=end
