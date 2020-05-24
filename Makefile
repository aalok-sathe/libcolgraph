#!/bin/bash

####    begin Makefile  ####


########################
#### definitions    ####
########################

MODULE      =   libcolgraph
CSOURCES    =   $(wildcard $(MODULE)/*.h) $(MODULE)/Graph.cpp $(MODULE)/Vertex.cpp
ISOURCES    =   $(wildcard $(MODULE)/*.i) $(wildcard $(MODULE)/swigsrc/*.i)
SOURCES     =   Makefile setup.py
TARGET      =   $(MODULE)/$(MODULE).py # $(MODULE)/$(MODULE)_wrap.cpp


############################
####    main targets    ####
############################

default: build

all: build docs

build: swig $(TARGET) exist 

again: clean build

#$(SOURCES)
$(TARGET): $(CSOURCES) $(ISOURCES) $(MODULE)/swigsrc/docs.i
	echo "building target $@"
	# $(MAKE) -C $(MODULE)
	python3 setup.py build_ext --inplace

%.h: %.cpp

#refresh: $(ISOURCES)
#	echo "need to refresh after changed $(ISOURCES)"
#	#$(MAKE) clean

swig: 
	./utils/getswig.sh
	export PATH="$(PATH):$(HOME)/.swig/bin"

exist:
	if  [ ! -f $(TARGET) ]; then \
		$(MAKE) clean; \
		$(MAKE); \
	fi
	if  [ ! -f $(MODULE)/*.so ]; then \
		$(MAKE) clean; \
		$(MAKE); \
	fi

########################
####    packaging   ####
########################

package: swig $(TARGET)
	python3 setup.py sdist bdist_wheel

trigger:
	python3 utils/insertversion.py
	date | cat > .pipeline.trigger

docs: Doxyfile $(MODULE)/swigsrc/docs.i $(wildcard $(MODULE)/**/%.py) $(TARGET) README.md
	pdoc -o docs --html --force libcolgraph
	mkdir -p public/
	cp -r docs/libcolgraph public/

$(MODULE)/swigsrc/docs.i: $(CSOURCES) doxy2swig.py
	doxygen Doxyfile
	python3 doxy2swig.py docs/xml/index.xml libcolgraph/swigsrc/docs.i -catfo

doxy2swig.py:
	wget https://raw.githubusercontent.com/m7thon/doxy2swig/master/doxy2swig.py

####################
####    cleanup ####
####################

clean:
	find . -name "*.pyc" -type f -delete
	find . -name "__pycache__" -type f -delete
	python3 setup.py clean
	rm -rf build dist *.egg-info
	rm -rf $(MODULE)/*.so
	rm -f $(TARGET)
	rm -rf docs/


################################################
####    installing and uninstalling module  ####
################################################

install: package deps
	echo "INFO installing $(MODULE)"
	python3 setup.py install --user

deps: requirements.txt
	python3 utils/install.py
	# pip3 install -r requirements.txt

uninstall: clean
	echo "uninstalling $(MODULE)"
	pip3 uninstall -y libcolgraph


############

.SILENT: exist
.PHONY: default all build again refresh swig exist package trigger docs clean install deps uninstall


####    end Makefile    ####

