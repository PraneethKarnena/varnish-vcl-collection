# purge.vcl -- Cache Purge Library for Varnish
#
# Copyright (C) 2013 DreamHost (New Dream Network, LLC)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This file is a heavily modified version the original file.

sub vcl_recv {
	if (req.method == "PURGE") {
 		if (!client.ip ~ purger) {
 		return(synth(405, "This IP is not allowed to send PURGE requests."));
   			}
 	return (purge);
 		}
		
		sub vcl_purge {
 			set req.method = "GET";
 			set req.http.X-Purger = "Purged";
 			return (restart);
		}
}

