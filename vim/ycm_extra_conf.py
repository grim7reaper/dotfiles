#!/usr/bin/env python
# coding: utf-8

def FlagsForFile(filename, **kwargs):
    flags = [ '-pipe', '-Weverything' ]
    filetype = kwargs['client_data']['&filetype']
    if filetype == 'c':
        flags += ['--std=c89']
    elif filetype == 'cpp':
        flags += ['--std=c++11']
    elif filetype == 'objc':
        flags += ['-ObjC']
    else:
        flags = []
    return {
        'flags':    flags,
        'do_cache': True
    }
