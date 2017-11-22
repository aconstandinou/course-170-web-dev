https://learn.shayhowe.com/html-css/getting-to-know-html/

############### GETTING TO KNOW HTML ##################

# Semantics Overview

Semantics: giving content and structure of the page
          proper element usage.

Semantic code: describes value of content on a page,
               regardless of the style or appearance
               of that content.

Its easier to manage and work with as well.

# First Look: <div>s and <span>s

Divisions, or <div>s, and <span>s are HTML elements
that act as containers solely for styling purposes.
As generic containers, they do not come with any
overarching meaning or semantic value. Paragraphs
are semantic in that content wrapped within a
<p> element is known and understood as a paragraph.
<div>s and <span>s do not hold any such meaning and
are simply containers.

# Block vs. Inline Elements

Most elements are either block- or inline-level
elements. What’s the difference?

Block-level elements begin on a new line, stacking
one on top of the other, and occupy any available
width. Block-level elements may be nested inside one
another and may wrap inline-level elements. We’ll
most commonly see block-level elements used for larger
pieces of content, such as paragraphs.

Inline-level elements do not begin on a new line. They
fall into the normal flow of a document, lining up one
after the other, and only maintain the width of their
content. Inline-level elements may be nested inside one
another; however, they cannot wrap block-level elements.
We’ll usually see inline-level elements with smaller
pieces of content, such as a few words.



# <div>
block-level element that is commonly used to identify
large groupings of content, and which helps to
build a web page’s layout and design

# <span>
inline-level element commonly used to identify
smaller groupings of text within a block-level
element.

We’ll commonly see <div>s and <span>s with class or
id attributes for styling purposes

Note: Choose names for class or id attributes that
     are logical to the div or span.

Ex: We have a social media profile for our website.
   Why not name the class "social"

<!-- Division -->
<div class="social">
  <p>I may be found on...</p>
  <p>Additionally, I have a profile on...</p>
</div>

<!-- Span -->
<p>Soon well be <span class="tooltip">writing HTML</span> with the best of them.</p>

#HTML/CSS COMMENTS
HTML comments start with <!-- and end with -->.
CSS comments start with /* and end with */.


#################### HEADINGS #########################

- block level elements
- Ranked <h1> thru <h6>

<h1>Heading Level 1</h1>
<h2>Heading Level 2</h2>
<h3>Heading Level 3</h3>
<h4>Heading Level 4</h4>
<h5>Heading Level 5</h5>
<h6>Heading Level 6</h6>

################## PARAGRAPHS ######################

- block level element
- defined by <p>

Ex:
<p>Steve Jobs was a co-founder and longtime chief executive officer at Apple. On June 12, 2005, Steve gave the commencement address at Stanford University.</p>

<p>In his address Steve urged graduates to follow their dreams and, despite any setbacks, to never give up&ndash;advice which he sincerely took to heart.</p>

# BOLD TEXT WITH STRONG

- inline level element
- make text bold and place strong importance

<strong> and <b>

The <strong> element is semantically used to give
strong importance to text, and is thus the most
popular option for bolding text. The <b> element,
on the other hand, semantically means to
stylistically offset text

Ex:
<!-- Strong importance -->
<p><strong>Caution:</strong> Falling rocks.</p>

<!-- Stylistically offset -->
<p>This recipe calls for <b>bacon</b> and <b>baconnaise</b>.</p>

# ITALICIZE TEXT WITH EMPHASIS

- <em> inline level element
- <i> element is used semantically to convey text
in an alternative voice or tone, almost as if
it were placed in quotation marks

Ex:
<!-- Stressed emphasis -->
<p>I <em>love</em> Chicago!</p>

<!-- Alternative voice or tone -->
<p>The name <i>Shay</i> means a gift.</p>


################# BUILDING STRUCTURE #######################

HTML5 introduced new structural based Elements
<header>, <nav>, <article>, <section>, <aside>, <footer> elements.


Refer to Fig 2.01


# HEADER
<header> vs. <head> vs. <h1> - <h6> Elements

The <header> element is a structural element that
outlines the heading of a segment of a page. It
falls within the <body> element.

The <head> element is not displayed on a page and
is used to outline metadata, including the
document title, and links to external files. It
falls directly within the <html> element.

Heading elements, <h1> through <h6>, are used to
designate multiple levels of text headings
throughout a page.


# Navigation
- <nav> element identifies a section of major navigational
links

- <nav> element reserved for primary navigation
sections only, such as global navigation, a
table of contents, previous/next links, or other
noteworthy groups of navigational links.

Most commonly, links included within the <nav>
element will link to other pages within the same
website or to parts of the same web page.
Miscellaneous one-off links should not be
wrapped within the <nav> element; they should
use the anchor element, <a>

# Article

used to identify a section of independent, self-
contained content that may be independently distributed or
reused.
Ex: mark up blog posts, news articles, user-submitted content

How to determine to use or not?
Determine if the content within the element would be
replicated elsewhere without any confusion. Ie, if we copied
that content into an email, it would still make sense Within
the context of that email as it is pasted.

# Section

- used to identify
























.
