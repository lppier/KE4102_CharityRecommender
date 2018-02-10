## A Knowledge based system to recommend charities in Singapore

[1. Data Set](#data-set)

[2. How to Import facts from CSV file](#how-to-import-facts-from-csv-file)

### Data Set

https://drive.google.com/open?id=1zZZCicFEp8QhmHZtcvcodB4AA6bZJoGp

**Description**
* **Charities_all_remove_duplicates.csv** contains all of the charities that we scraped from Charities.gov.sg.
* **Charities_registered.csv** contains all of the registered charities in Singapore.
* **Charities_with_ipc.csv** contains all of the charities in Singapore with IPC status.
* **Charities_with_tax_exempt.csv** contains all of the charities that benefit from tax exemption.
* **Charities_code_compliances.csv** contains the latest charities’ code of compliance information. Each entry stores one item of code of compliance. So one charity can consist of multiple code of compliance entries in this file.
* **Charities_financial_information.csv** contains the last three years of charities’ financial information.

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
CLIPS> (CSV-import "filename" template-name)
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
