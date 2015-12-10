GITREPO=${HOME}/seal/clones/joomla-cms
IRISHREPO=${HOME}/seal/language_pack
# see $(GITREPO)/language/en-GB/install.xml for these values
POINTVERSION=3.5
VERSION=3.5.0
# can increment this without updating Joomla! release
LANGPACKREV=1
FULLVERSION=$(VERSION).$(LANGPACKREV)
VVERSION=$(VERSION)v$(LANGPACKREV)

all: ga-IE_joomla_lang_full_$(VERSION)v1.zip ga-IE-installation_$(VERSION)v1.zip

ga-IE_joomla_lang_full_$(VERSION)v1.zip: site_ga-IE.zip admin_ga-IE.zip pkg_ga-IE.xml
	zip $@ site_ga-IE.zip admin_ga-IE.zip pkg_ga-IE.xml
	cp -f $@ ${HOME}/public_html/gnu/joomla

ga-IE-installation_$(VERSION)v1.zip:
	rm -Rf installation
	mkdir installation
	mkdir installation/language
	mkdir installation/language/ga-IE
	cat $(GITREPO)/installation/language/en-GB/en-GB.ini | perl joomla.pl > installation/language/ga-IE/ga-IE.ini
	cp installation/language/ga-IE/ga-IE.ini $(IRISHREPO)/ga-IE_joomla_installation/installation/language/ga-IE/ga-IE.ini
	cat ga-IE.xml | sed "s/PACKTYPE/installation/; s/POINTVERSION/$(POINTVERSION)/g; s/VVERSION/$(VVERSION)/g; s/FULLVERSION/$(FULLVERSION)/g; s/VERSION/$(VERSION)/g; s/CREATIONDATE/`date +20%y-%m-%d`/" | sed '/<description>/s/.*/&\n\t<files><filename>ga-IE.ini<\/filename><\/files>/' | sed '/<locale>/d; /<firstDay>/d; /<weekEnd>/d' > installation/language/ga-IE/ga-IE.xml
	cp installation/language/ga-IE/ga-IE.xml $(IRISHREPO)/ga-IE_joomla_installation/installation/language/ga-IE/ga-IE.xml
	zip -r $@ installation/

pkg_ga-IE.xml: pkg-template.xml makefile
	cat pkg-template.xml | sed "s/POINTVERSION/$(POINTVERSION)/g; s/VVERSION/$(VVERSION)/g; s/FULLVERSION/$(FULLVERSION)/g; s/VERSION/$(VERSION)/g; s/CREATIONDATE/`date +20%y-%m-%d`/" > $@
	cp pkg_ga-IE.xml $(IRISHREPO)/ga-IE_joomla_lang_full

#(cd $(GITREPO)/administrator/language/en-GB; ls *.ini) | keepif admin.txt | while read x; do cat $(GITREPO)/administrator/language/en-GB/$$x | perl joomla.pl > ga-IE/`echo $$x | sed 's/^en-GB/ga-IE/'`; done
#(cd $(GITREPO)/administrator/language/en-GB; ls *.ini) | keepif -n admin.txt | while read x; do cat $(GITREPO)/administrator/language/en-GB/$$x > ga-IE/`echo $$x | sed 's/^en-GB/ga-IE/'`; done
admin_ga-IE.zip:
	rm -Rf ga-IE
	mkdir ga-IE
	(cd $(GITREPO)/administrator/language/en-GB; ls *.ini) | while read x; do cat $(GITREPO)/administrator/language/en-GB/$$x | perl joomla.pl > ga-IE/`echo $$x | sed 's/^en-GB/ga-IE/'`; done
	cp ga-IE.xml install.xml ga-IE.localise.php ga-IE/
	(cd ga-IE; ls *.ini | sed 's/.*/        <filename>&<\/filename>/' > temp.txt; sed -i '/<files>/r temp.txt' install.xml; sed -i "s/PACKTYPE/administrator/; s/POINTVERSION/$(POINTVERSION)/g; s/VVERSION/$(VVERSION)/g; s/FULLVERSION/$(FULLVERSION)/g; s/VERSION/$(VERSION)/g; s/CREATIONDATE/`date +20%y-%m-%d`/" *.xml)
	rm -f ga-IE/temp.txt
	(cd ga-IE; zip $@ *.ini *.xml *.php; mv $@ ..; cp *.ini *.xml *.php $(IRISHREPO)/ga-IE_joomla_lang_full/admin_ga-IE/)

site_ga-IE.zip:
	rm -Rf ga-IE
	mkdir ga-IE
	(cd $(GITREPO)/language/en-GB; ls *.ini) | while read x; do cat $(GITREPO)/language/en-GB/$$x | perl joomla.pl > ga-IE/`echo $$x | sed 's/^en-GB/ga-IE/'`; done
	cp ga-IE.xml install.xml ga-IE.localise.php ga-IE/
	(cd ga-IE; ls *.ini | sed 's/.*/        <filename>&<\/filename>/' > temp.txt; sed -i '/<files>/r temp.txt' install.xml; sed -i "s/PACKTYPE/site/; s/POINTVERSION/$(POINTVERSION)/g; s/VVERSION/$(VVERSION)/g; s/FULLVERSION/$(FULLVERSION)/g; s/VERSION/$(VERSION)/g; s/CREATIONDATE/`date +20%y-%m-%d`/" *.xml)
	rm -f ga-IE/temp.txt
	(cd ga-IE; zip $@ *.ini *.xml *.php; mv $@ ..; cp *.ini *.xml *.php $(IRISHREPO)/ga-IE_joomla_lang_full/site_ga-IE/)

# also clar/script/updateclones does this...
updategit: FORCE
	(cd $(GITREPO); git pull)

# some .ini files don't have a newline at the end, hence the sed trick
#  instead of a simple cat
ini.txt: $(GITREPO)/language/en-GB/*.ini $(GITREPO)/administrator/language/en-GB/*.ini $(GITREPO)/installation/language/en-GB/en-GB.ini
	sed '$$s/$$/\n/' $(GITREPO)/language/en-GB/*.ini > $@
	(cd $(GITREPO)/administrator/language/en-GB; ls *.ini) | keepif admin.txt | sed "s@^@$(GITREPO)/administrator/language/en-GB/@" | xargs sed '$$s/$$/\n/'  >> $@
	sed '$$s/$$/\n/' $(GITREPO)/installation/language/en-GB/en-GB.ini >> $@

joomla.pot: ini.txt
	(echo 'msgid ""'; echo 'msgstr ""'; echo '"Content-Type: text/plain; charset=UTF-8\\n"'; echo) > $@
	cat ini.txt | perl topot.pl >> $@

#	perl fuzzy.pl > maybe-better.po
joomla-1.0.ga.po: joomla.pot
	cp -f joomla-1.0.ga.po joomla-prev.ga.po
	msgmerge -q --backup=off -U $@ joomla.pot > /dev/null 2>&1
	touch $@
	cpo -q joomla-prev.ga.po $@

clean:
	rm -Rf ga-IE installation
	rm -f ini.txt joomla.pot ini-ga.txt joomla-prev.ga.po *.zip pkg_ga-IE.xml

FORCE:
