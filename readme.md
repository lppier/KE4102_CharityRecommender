## A Knowledge based system to recommend charities in Singapore

### How to Import facts from CSV file

1. Define a template 

**Example**
```
(deftemplate link
  (slot title (type STRING))
  (slot url (type STRING))
  (slot category (type STRING))
)
```

2. Insert all the facts to a CSV file

**Example**
```
title,url,category
"CLIPSESG","http://groups.google.com/group/CLIPSESG","code"
"CLIPS","http://clipsrules.sourceforge.net/","book"
```

3. Run CSV-Import command

**Format**
```
CLIPS> CSV-import "filename" template-name
```
**Example**
```
CLIPS> (CSV-import "link.csv" link)
```

4. Verify the facts
```
CLIPS> (facts)
f-1     (link (title "CLIPSESG") (url "http://groups.google.com/group/CLIPSESG") (category "code"))
f-2     (link (title "CLIPS") (url "http://clipsrules.sourceforge.net/") (category "book"))
For a total of 2 facts.

```
