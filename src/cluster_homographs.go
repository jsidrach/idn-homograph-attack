// Clusters the domain names according to their non-IDN homograph

// Important: requires top domains file, called ../data/com-alexa-top-not-idn-20170501.gz
// Important: requires idns file, called ../data/com-zone-idn-20170501.gz

// Format of the standard output:
// Rank,Canonical,Unicode,Punycode

package main

import (
	"bufio"
	"compress/gzip"
	"fmt"
	"log"
	"os"

	"golang.org/x/net/idna"

	"homographs"
)

func main() {
	c := clusters{}
	c.canonicals = make([]string, 0, 0)
	c.cluster = make(map[string]*domain)
	// Process canonical domains
	fDomains, err := os.Open(DomainsFile)
	if err != nil {
		log.Fatal(err)
	}
	defer fDomains.Close()
	gzDomains, err := gzip.NewReader(fDomains)
	if err != nil {
		log.Fatal(err)
	}
	defer gzDomains.Close()
	scDomains := bufio.NewScanner(gzDomains)
	for scDomains.Scan() {
		processCRecord(scDomains.Text(), &c)
	}
	// Process IDNs
	fIDNs, err := os.Open(IDNsFile)
	if err != nil {
		log.Fatal(err)
	}
	defer fIDNs.Close()
	gzIDNs, err := gzip.NewReader(fIDNs)
	if err != nil {
		log.Fatal(err)
	}
	defer gzIDNs.Close()
	scIDNs := bufio.NewScanner(gzIDNs)
	for scIDNs.Scan() {
		processIDNRecord(scIDNs.Text(), &c)
	}
	// Print clusters
	c.Print()
}

const (
	// Domains file
	// 	Format:
	// 		rank,name
	DomainsFile = "../data/com-alexa-top-not-idn-20170501.gz"
	// IDNs file
	// 	Format:
	// 		punycode
	IDNsFile = "../data/com-zone-idn-20170501.gz"
)

type clusters struct {
	nC         uint
	nCWithIDN  uint
	nIDNs      uint
	nIDNsWithC uint
	canonicals []string
	cluster    map[string]*domain
}

type domain struct {
	rank uint
	idns []string
}

// Processes a canonical record
func processCRecord(l string, c *clusters) {
	var r uint
	var k string
	fmt.Sscanf(l, "%d,%s", &r, &k)
	c.canonicals = append(c.canonicals, k)
	c.cluster[k] = &domain{rank: r, idns: make([]string, 0, 0)}
	c.nC += 1
}

// Processes a IDN record
func processIDNRecord(l string, c *clusters) {
	idn, err := idna.ToUnicode(l)
	if err != nil {
		log.Fatal(err)
	}
	k := homographs.Skeleton(idn)
	if cluster, ok := c.cluster[k]; ok {
		if len(cluster.idns) == 0 {
			c.nCWithIDN += 1
		}
		cluster.idns = append(cluster.idns, idn)
		c.nIDNsWithC += 1
	}
	c.nIDNs += 1
}

// Prints the domains clustered by their canonical domain names
func (c *clusters) Print() {
	fmt.Fprintf(os.Stderr, "Number of canonical domain names: %d\n", c.nC)
	fmt.Fprintf(os.Stderr, "Number of canonical domains with IDN homographs: %d\n", c.nCWithIDN)
	fmt.Fprintf(os.Stderr, "Number of canonical domains without IDN homographs: %d\n", c.nC-c.nCWithIDN)
	fmt.Fprintf(os.Stderr, "Number of IDNs: %d\n", c.nIDNs)
	fmt.Fprintf(os.Stderr, "Number of IDNs with canonical counterpart: %d\n", c.nIDNsWithC)
	fmt.Fprintf(os.Stderr, "Number of IDNs without canonical counterpart: %d\n\n", c.nIDNs-c.nIDNsWithC)
	fmt.Fprint(os.Stderr, "Clusters:\n")
	for _, k := range c.canonicals {
		d := c.cluster[k]
		if len(d.idns) > 0 {
			fmt.Print(d.Format(k))
		}
	}
}

// Prints a domain name with all its associated homograph IDNs
func (d *domain) Format(canonical string) string {
	fmt.Fprintf(os.Stderr, "%s - %d IDN homographs\n", canonical, len(d.idns))
	s := ""
	for _, idn := range d.idns {
		ascii, err := idna.ToASCII(idn)
		if err != nil {
			log.Fatal(err)
		}
		s += fmt.Sprintf("%d,%s,%s,%s\n", d.rank, canonical, idn, ascii)
	}
	return s
}
