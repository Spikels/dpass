# TODO

## SALT

* Create salt file (~/.dpass)
** Check if file already exists. If so abort with message to delete manually if you really want a NEW salt file.
** Generate 128-bit random salt (32 hex chars)
** Save to file ~/.dpass
** ??? Set permission to 600 ???

* Read salt file (~/.dpass)
** Check that file exists. If not abort with message to copy existing salt or create new salt if you REALLY want to.
** Read salt file
** Check salt is 32 hex chars
** ??? Check that salt seems random ???

