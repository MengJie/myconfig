svn propget svn:ignore . > prop.tmp
vim prop.tmp
svn propset svn:ignore --file prop.tmp .
rm prop.tmp

