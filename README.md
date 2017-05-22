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
  * [Confusable homoglyphs](data/confusables.txt)
  * Domains
    * [Number of domains studied, date of data snapshots](data/filtered-domains.txt)
    * [Alexa Top 1m Websites](data/alexa-top-1m-20170501.gz)
      * [Alexa Top .com Websites - excluding IDNs](data/alexa-top-not-idn-20170501.gz)
    * [.com zone IDNs](data/com-zone-idn-20170501.gz)
      * [.com zone IDNs Name Servers](data/com-zone-ns-idn-20170501.gz)
    * [IDN clusters](data/clustered-idns-20170501.csv)
      * [IDN clusters statistics](data/stats-clustered-domains.csv)
      * [IDN clusters with basic WHOIS information](data/clustered-idns-whois-20170501.csv)
    * [Manually classified homograph IDNs](data/manually-classified-idns-20170501.csv)
      * [Manually classified homograph IDNs statistics](data/stats-classified-domains.txt)
* Source Code
  * [Initial raw data filtering](src/filter_domains.sh)
  * [Clustering of homograph IDNs](src/cluster_homographs.go)
    * [Homographs detection library](src/homographs/homographs.go)
    * [Homoglyphs dictionary generator](src/homographs/generate_confusables.go)
    * [Homoglyphs dictionary](src/homographs/confusables_map.go)
  * [Retrieval of IDNs WHOIS information](src/whois_homographs.sh)
  * TODO: Source code to generate graphs

### Commands
* Generate PDFs
  * Requirements: xelatex, bibtex
  * Run ```make all``` inside the [docs/](docs/) folder
* Process data
  * Requirements: .com zone snapshot (named ```data/com-zone-20170501.gz```), whois, golang, [src/](src/) directory included in golang's ```$GOPATH```
  * ```make confusables``` generates confusables map
  * ``` make filter``` filters the raw data
  * ```make cluster``` clusters homograph IDNs
  * ```make whois``` retrieves homograph IDNs WHOIS information
* TODO: Instructions to generate graphics, etc.

### Acknowledgements
* [Louis DeKoven](http://ldekoven.com) and [Stefan Savage](https://cseweb.ucsd.edu/~savage/)  and for their help and guidance

### References
* [Unicode Confusable Detection](http://www.unicode.org/reports/tr39/#Confusable_Detection)
* [Unicode Confusables Library](https://github.com/mtibben/confusables)
