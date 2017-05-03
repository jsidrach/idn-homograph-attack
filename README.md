# Іntеrnɑtⅰonɑlⅰzеⅾ Dоmɑⅰn Nɑmе Hоmоɡrɑρh Attɑсκѕ
## CSE 227: Computer Security
### University of California San Diego
#### Spring 2017

### Authors
* [Chen Lai](https://github.com/claigit)
* [Zhongrong Jian](https://github.com/miaolegewang)
* [J. Sidrach](https://github.com/jsidrach)

### Contents
* Documents
  * [Proposal](docs/proposal.pdf)
  * [Paper](docs/paper.pdf)
  * [Presentation](docs/presentation.pdf)
* Data
  * [Confusable Homoglyphs](data/confusables.txt)
  * Domains
    * [Alexa Top 1m Websites](data/alexa-top-1m-20170501.gz)
    * [Alexa Top .com Websites - excluding IDNs](data/alexa-top-not-idn-20170501.gz)
    * [.com Zone IDNs](data/com-zone-idn-20170501.gz)
    * [.com Zone IDNs Name Servers](data/com-zone-ns-idn-20170501.gz)
    * [Number of domains studied](data/filtered-domains.txt)
  * TODO: Data output from clustering
* Source Code
  * [Initial raw data filtering](src/filter-domains.sh)
  * [Homograph detection library](src/homographs.go)
    * [Homoglyphs dictionary generator](src/generate_confusables.go)
    * [Homoglyphs dictionary](src/confusables_map.go)
  * TODO: Source code to cluster domains

### Commands
* Generate PDFs: run ```make docs``` inside the project's root folder
* TODO: Instructions to run code, filter data, generate graphics, etc.

### Acknowledgements
* [Louis DeKoven](http://ldekoven.com) and [Stefan Savage](https://cseweb.ucsd.edu/~savage/)  and for their help and guidance

### References
* [Unicode Confusable Detection](http://www.unicode.org/reports/tr39/#Confusable_Detection)
* [Unicode Confusables Library](https://github.com/mtibben/confusables)
