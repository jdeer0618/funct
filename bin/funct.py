#!/usr/bin/env python
# coding=utf-8
#
# Copyright © 2011-2015 Splunk, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"): you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

from __future__ import absolute_import, division, print_function, unicode_literals
from splunklib.searchcommands import dispatch, StreamingCommand, Configuration, Option, validators
import sys
import re


@Configuration()
class functCommand(StreamingCommand):
    """ Counts the number of non-overlapping matches to a regular expression in a set of fields.

    ##Syntax

    .. code-block::
        countmatches fieldname=<field> pattern=<regular_expression> <field-list>

    ##Description

    A count of the number of non-overlapping matches to the regular expression specified by `pattern` is computed for
    each record processed. The result is stored in the field specified by `fieldname`. If `fieldname` exists, its value
    is replaced. If `fieldname` does not exist, it is created. Event records are otherwise passed through to the next
    pipeline processor unmodified.

    ##Example

    Count the number of words in the `text` of each tweet in tweets.csv and store the result in `word_count`.

    .. code-block::
        | inputlookup tweets | countmatches fieldname=word_count pattern="\\w+" text

    """
    fieldname = Option(
        doc='''
        **Syntax:** **fieldname=***<fieldname>*
        **Description:** Name of the field that will hold the match count''',
        require=True, validate=validators.Fieldname())

    def stream(self, records):
        self.logger.debug('functCommand: %s', self)  # logs command line
        for record in records:
            for fieldname in self.fieldnames:
                x = record[fieldname]
                if re.search(r'\W{1}', record[fieldname]):
                   x = re.sub(r'\w', "", x)
                   x = re.sub(r'\s', "_", x)
                   record[self.fieldname] = x
                else:
                   x = re.sub(r'[B-Z]', "A", x)
                   x = re.sub(r'[b-z]', "a", x)
                   x = re.sub(r'[0-8]', "9", x)
                   x = re.sub(r'\s', "w", x)
                   record[self.fieldname] = x
            yield record
dispatch(functCommand, sys.argv, sys.stdin, sys.stdout, __name__)
