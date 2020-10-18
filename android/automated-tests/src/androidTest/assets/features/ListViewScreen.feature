#
# Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

@listview @regression
Feature: ListView Component Validation

    As a Beagle developer/user
    I'd like to make sure my listView component works as expected
    In order to guarantee that my application never fails

    Background:
        Given that I'm on the listView screen with id list

#    Scenario Outline: ListView 01 - listView component renders all items
#        Then listView at <position> renders view with <id> and <text>
#
#        Examples:
#            | position | id     | text      |
#            | 0        | text:0 | 1 OUTSIDE |
#            | 1        | text:1 | 2 OUTSIDE |
#            | 2        | text:2 | 3 OUTSIDE |
#            | 3        | text:3 | 4 OUTSIDE |
#            | 4        | text:4 | 5 OUTSIDE |
#            | 5        | text:5 | 6 OUTSIDE |
#            | 6        | text:6 | 7 OUTSIDE |
#            | 7        | text:7 | 8 OUTSIDE |

    Scenario: ListView 02 - listView component renders all items
        Then listView screen should render all items correctly
#
#    Scenario: ListView 01 - listView component renders all items
#
#    Scenario: ListView 01 - listView component renders all items

#    Scenario: ListView 01 - listView component renders text attribute correctly
#        Then listview screen should render all text attributes correctly

#    Scenario: ListView 02 - listView component performs vertical scroll correctly
#        When I have a vertical list configured
#        Then listview screen should perform the scroll action vertically

#    Scenario: ListView 03 - listView component performs horizontal scroll correctly
#        When I have a horizontal list configured
#        Then listview screen should perform the scroll action horizontally