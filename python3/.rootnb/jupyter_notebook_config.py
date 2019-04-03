import os
rootbin = '/usr/local/root/bin'
rootlib = '/usr/local/root/lib'
os.environ['PYTHONPATH']      = '%s' % rootlib + ':' + os.getenv('PYTHONPATH', '')
os.environ['PATH']            = '%s:%s/bin' % (rootbin,rootbin) + ':' + os.getenv('PATH', '')
os.environ['LD_LIBRARY_PATH'] = '%s' % rootlib + ':' + os.getenv('LD_LIBRARY_PATH', '')
c.NotebookApp.ip = '*'
