import os.path, platform
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy

#bits,foo = platform.architecture()

#
# Build the pyd with python setup.py build_ext --inplace
#
desc = """Wrapper for AMD's OpenVideo ENCODE library"""

INCLUDEDIR = r'../include'
LIBDIR = r'../lib'

setup(
    name = 'encode',
    version = '0.1',
    description = desc,
    cmdclass = {'build_ext': build_ext},                  
    #packages = [''],
    ext_modules = [Extension("encode",
                             ["encode.pyx"],
                             include_dirs = [".",
                                             INCLUDEDIR,
                                             numpy.get_include(),
                                             ],
                             extra_compile_args = [],
                             extra_link_args = [],
                             libraries = [],
                             library_dirs = [LIBDIR]
                             )
                   ],
    )