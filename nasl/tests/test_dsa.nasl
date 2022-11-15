# Copyright (C) 2009-2022 Greenbone Networks GmbH
#
# SPDX-License-Identifier: GPL-2.0-or-later
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.

# OpenVAS Testsuite for the NASL interpreter
# Description: Tests for the nasl functions dsa_do_sign and dsa_do_verify

# rsa key generated with ssh-keygen -t dsa -f keyfile
dsa_key_plain = string(
"-----BEGIN DSA PRIVATE KEY-----\n",
"MIIBuwIBAAKBgQCWLwS7cJ59aAc12fY2ZDjEVB+NsDxoH+TpD+gzJx2sYJ4XqMkV\n",
"DYdSMcZ9gaVyXE5cWDw152c01VkpEPt4rUFA9ZGGdrqIM6rLytMsBQioJNG/qrB+\n",
"6wgPFEZafkoGXgM6eCs8jXDKCN6vcQq1ByovLDTEmvyqnQKoeDraQH/jpwIVAOzW\n",
"fhGJLXSAAzYGVBxGKlATA681AoGAJn/oThmueo8LQ+yif3m5T09X5TJU5TtxD9wo\n",
"TRw80c7AL59dTUsriDILVeo42jtCG/AmPgIZdxvIsCGPdOIFwpcppfxa/IC6jW4s\n",
"pFp8/GSFmxhCSU7g3AnSJX/LQUWELcf9AZPT9ArMP7oy9QYYWmJrFyxaOjFQetid\n",
"/qRnKfcCgYBeVrmBMRb99dxE2N6V/r/fwaK/WG05Tf1inXnh5lDRwAB0kOnoR2XW\n",
"T26p7pEkrbCie0ylJho1K8TMqE5ZhMzhEY/iufZ0s7yS1iL4nioO8ETfCAjroeUr\n",
"wr6JVtVZZ2wvzIJ4Y2zKojmWbcWRCCkm/3ufIAKxx9WV8O0ZUnXKIwIVAKaF08dV\n",
"I58zgmgYo6X07kCJJiQb\n",
"-----END DSA PRIVATE KEY-----\n");

# key parameters extracted from dsa_key_plain's pubkey file
p = raw_string(0x00, 0x96, 0x2f, 0x04, 0xbb, 0x70, 0x9e, 0x7d,
	       0x68, 0x07, 0x35, 0xd9, 0xf6, 0x36, 0x64, 0x38,
	       0xc4, 0x54, 0x1f, 0x8d, 0xb0, 0x3c, 0x68, 0x1f,
	       0xe4, 0xe9, 0x0f, 0xe8, 0x33, 0x27, 0x1d, 0xac,
	       0x60, 0x9e, 0x17, 0xa8, 0xc9, 0x15, 0x0d, 0x87,
	       0x52, 0x31, 0xc6, 0x7d, 0x81, 0xa5, 0x72, 0x5c,
	       0x4e, 0x5c, 0x58, 0x3c, 0x35, 0xe7, 0x67, 0x34,
	       0xd5, 0x59, 0x29, 0x10, 0xfb, 0x78, 0xad, 0x41,
	       0x40, 0xf5, 0x91, 0x86, 0x76, 0xba, 0x88, 0x33,
	       0xaa, 0xcb, 0xca, 0xd3, 0x2c, 0x05, 0x08, 0xa8,
	       0x24, 0xd1, 0xbf, 0xaa, 0xb0, 0x7e, 0xeb, 0x08,
	       0x0f, 0x14, 0x46, 0x5a, 0x7e, 0x4a, 0x06, 0x5e,
	       0x03, 0x3a, 0x78, 0x2b, 0x3c, 0x8d, 0x70, 0xca,
	       0x08, 0xde, 0xaf, 0x71, 0x0a, 0xb5, 0x07, 0x2a,
	       0x2f, 0x2c, 0x34, 0xc4, 0x9a, 0xfc, 0xaa, 0x9d,
	       0x02, 0xa8, 0x78, 0x3a, 0xda, 0x40, 0x7f, 0xe3,
	       0xa7);
q = raw_string(0x00, 0xec, 0xd6, 0x7e, 0x11, 0x89, 0x2d, 0x74,
	       0x80, 0x03, 0x36, 0x06, 0x54, 0x1c, 0x46, 0x2a,
	       0x50, 0x13, 0x03, 0xaf, 0x35);
g = raw_string(0x26, 0x7f, 0xe8, 0x4e, 0x19, 0xae, 0x7a, 0x8f,
	       0x0b, 0x43, 0xec, 0xa2, 0x7f, 0x79, 0xb9, 0x4f,
	       0x4f, 0x57, 0xe5, 0x32, 0x54, 0xe5, 0x3b, 0x71,
	       0x0f, 0xdc, 0x28, 0x4d, 0x1c, 0x3c, 0xd1, 0xce,
	       0xc0, 0x2f, 0x9f, 0x5d, 0x4d, 0x4b, 0x2b, 0x88,
	       0x32, 0x0b, 0x55, 0xea, 0x38, 0xda, 0x3b, 0x42,
	       0x1b, 0xf0, 0x26, 0x3e, 0x02, 0x19, 0x77, 0x1b,
	       0xc8, 0xb0, 0x21, 0x8f, 0x74, 0xe2, 0x05, 0xc2,
	       0x97, 0x29, 0xa5, 0xfc, 0x5a, 0xfc, 0x80, 0xba,
	       0x8d, 0x6e, 0x2c, 0xa4, 0x5a, 0x7c, 0xfc, 0x64,
	       0x85, 0x9b, 0x18, 0x42, 0x49, 0x4e, 0xe0, 0xdc,
	       0x09, 0xd2, 0x25, 0x7f, 0xcb, 0x41, 0x45, 0x84,
	       0x2d, 0xc7, 0xfd, 0x01, 0x93, 0xd3, 0xf4, 0x0a,
	       0xcc, 0x3f, 0xba, 0x32, 0xf5, 0x06, 0x18, 0x5a,
	       0x62, 0x6b, 0x17, 0x2c, 0x5a, 0x3a, 0x31, 0x50,
	       0x7a, 0xd8, 0x9d, 0xfe, 0xa4, 0x67, 0x29, 0xf7);
y = raw_string(0x5e, 0x56, 0xb9, 0x81, 0x31, 0x16, 0xfd, 0xf5,
	       0xdc, 0x44, 0xd8, 0xde, 0x95, 0xfe, 0xbf, 0xdf,
	       0xc1, 0xa2, 0xbf, 0x58, 0x6d, 0x39, 0x4d, 0xfd,
	       0x62, 0x9d, 0x79, 0xe1, 0xe6, 0x50, 0xd1, 0xc0,
	       0x00, 0x74, 0x90, 0xe9, 0xe8, 0x47, 0x65, 0xd6,
	       0x4f, 0x6e, 0xa9, 0xee, 0x91, 0x24, 0xad, 0xb0,
	       0xa2, 0x7b, 0x4c, 0xa5, 0x26, 0x1a, 0x35, 0x2b,
	       0xc4, 0xcc, 0xa8, 0x4e, 0x59, 0x84, 0xcc, 0xe1,
	       0x11, 0x8f, 0xe2, 0xb9, 0xf6, 0x74, 0xb3, 0xbc,
	       0x92, 0xd6, 0x22, 0xf8, 0x9e, 0x2a, 0x0e, 0xf0,
	       0x44, 0xdf, 0x08, 0x08, 0xeb, 0xa1, 0xe5, 0x2b,
	       0xc2, 0xbe, 0x89, 0x56, 0xd5, 0x59, 0x67, 0x6c,
	       0x2f, 0xcc, 0x82, 0x78, 0x63, 0x6c, 0xca, 0xa2,
	       0x39, 0x96, 0x6d, 0xc5, 0x91, 0x08, 0x29, 0x26,
	       0xff, 0x7b, 0x9f, 0x20, 0x02, 0xb1, 0xc7, 0xd5,
	       0x95, 0xf0, 0xed, 0x19, 0x52, 0x75, 0xca, 0x23);

# plaintext and corresponding signature made with dsa_key_plain
plain_text = "abc";
signature = raw_string();


function test_dsa_do_sign(p, g, q, pub, privkey, data)
{
  local_var priv, signature, r, s, verified;

  testcase_start("test_dsa_do_sign");

  priv = pem_to_dsa(priv:privkey, passphrase:"");
  signature = dsa_do_sign(p:p, g:g, q:q, pub:pub, priv:priv, data:data);

  r = substr(signature,  0, 19);
  s = substr(signature, 20, 39);

  verified = dsa_do_verify(p:p, g:g, q:q, pub:pub, r:r, s:s, data:data);
  if (verified)
    testcase_ok();
  else
    testcase_failed();
}

function test_dsa_do_verify(name, expect_valid, p, g, q, pub, r, s, data)
{
  local_var valid;

  testcase_start(string("test_dsa_do_verify ", name));

  valid = dsa_do_verify(p:p, g:g, q:q, pub:pub, r:r, s:s, data:data);
  if (valid == expect_valid)
    testcase_ok();
  else
    testcase_failed();
}

test_dsa_do_sign(p:p, g:g, q:q, pub:y, privkey:dsa_key_plain,
		 data:SHA1(plain_text));

test_dsa_do_verify(name:"valid", expect_valid:1, p:p, g:g, q:q, pub:y,
		   r:raw_string(0x70, 0x5a, 0xba, 0x76, 0x58, 0xfb, 0xeb, 0x09,
				0x5f, 0x58, 0xea, 0xf6, 0xca, 0x7b, 0xf5, 0x0d,
				0xdc, 0xab, 0x25, 0x70),
		   s:raw_string(0xc6, 0xb9, 0x49, 0x73, 0xa2, 0x9b, 0x58, 0x99,
				0x07, 0x3e, 0x71, 0x8b, 0x46, 0x1c, 0x8e, 0x72,
				0x67, 0xdf, 0x35, 0x14),
		   data:SHA1(plain_text));
test_dsa_do_verify(name:"wrong hash", expect_valid:0, p:p, g:g, q:q, pub:y,
		   r:raw_string(0x70, 0x5a, 0xba, 0x76, 0x58, 0xfb, 0xeb, 0x09,
				0x5f, 0x58, 0xea, 0xf6, 0xca, 0x7b, 0xf5, 0x0d,
				0xdc, 0xab, 0x25, 0x70),
		   s:raw_string(0xc6, 0xb9, 0x49, 0x73, 0xa2, 0x9b, 0x58, 0x99,
				0x07, 0x3e, 0x71, 0x8b, 0x46, 0x1c, 0x8e, 0x72,
				0x67, 0xdf, 0x35, 0x14),
		    data:SHA1("def"));
test_dsa_do_verify(name:"wrong sig", expect_valid:0, p:p, g:g, q:q, pub:y,
		   r:raw_string(0x70, 0x5a, 0xba, 0x76, 0x58, 0xfb, 0xeb, 0x09,
				0x5f, 0x58, 0xea, 0xf6, 0xca, 0x7b, 0xf5, 0x0d,
				0xdc, 0xab, 0x25, 0x71),
		   s:raw_string(0xc6, 0xb9, 0x49, 0x73, 0xa2, 0x9b, 0x58, 0x99,
				0x07, 0x3e, 0x71, 0x8b, 0x46, 0x1c, 0x8e, 0x72,
				0x67, 0xdf, 0x35, 0x14),
		   data:SHA1(plain_text));