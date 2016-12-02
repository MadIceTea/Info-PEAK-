BINDIR = bin
SRCDIR = src
PACKAGE = jp/ac/utokyo/c/graco/isrb
SRC = $(PACKAGE)/ImagePanel.java
JARFILE = isrb.jar
CLASSFILE = $(BINDIR)/$(PACKAGE)/ImagePanel.class
DISTFILE = src ruby isrb isrb.bat license.txt Makefile README.txt $(JARFILE)

RELEASE_TAG	= $$Name: release_20121001 $$
RELEASE	= $(strip $(subst $$,,$(subst Name: release_,,$(RELEASE_TAG))))

# should run on an exported directory
archive:	$(DISTFILE)
	chmod +x isrb;\
	(cd ..; \
	tar -z -f isrb2/isrb2-$(RELEASE).tar.gz -c $(DISTFILE:%=isrb2/%);\
	zip -r isrb2/isrb2-$(RELEASE).zip $(DISTFILE:%=isrb2/%))

$(JARFILE):	$(CLASSFILE)
	jar -cf $(JARFILE) -C $(BINDIR) jp 

$(CLASSFILE):	$(SRCDIR)/$(SRC) $(BINDIR)
	cd $(SRCDIR); javac -d ../$(BINDIR) $(SRC)

$(BINDIR):
	@mkdir $(BINDIR)


