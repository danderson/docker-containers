package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"net/url"
	"os"
)

func main() {
	redirects, err := parseRedirections(os.Args[1:])
	if err != nil {
		log.Fatalf("Failed to parse redirects: %s", err)
		os.Exit(1)
	}
	http.Handle("/", h(redirects))
	http.HandleFunc("/favicon.ico", http.NotFound)
	http.ListenAndServe(":8080", nil)
}

type h map[string]string

func (h h) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	r.URL.Host = r.Host
	m, err := URLToMatchString(r.URL.String())
	if err != nil {
		http.Error(w, "error", http.StatusInternalServerError)
		return
	}
	if to, ok := h[m]; ok {
		log.Printf("%s -> %s", m, to)
		http.Redirect(w, r, to, http.StatusFound)
	} else {
		log.Printf("%s -> no match", r.URL)
		http.NotFound(w, r)
	}
}

func parseRedirections(l []string) (map[string]string, error) {
	if len(l)%2 != 0 {
		return nil, fmt.Errorf("URLs must be in pairs, only got %d", len(l))
	}

	ret := make(map[string]string)
	for i := 0; i < len(l); i += 2 {
		m, err := URLToMatchString(l[i])
		if err != nil {
			return nil, err
		}
		to, err := url.Parse(l[i+1])
		if err != nil {
			return nil, err
		}
		ret[m] = to.String()
	}
	return ret, nil
}

func URLToMatchString(s string) (string, error) {
	u, err := url.Parse(s)
	if err != nil {
		return "", err
	}
	u.Scheme = ""
	u.Host = stripPort(u.Host)
	u.RawQuery = ""
	u.Fragment = ""
	return u.String(), nil
}

func stripPort(hostPort string) string {
	host, _, err := net.SplitHostPort(hostPort)
	if err != nil {
		return hostPort
	}
	return host
}
