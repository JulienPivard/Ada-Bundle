"------------------------------------------------------------------------------
"  Description: Vim Ada/GNAT compiler file
"     Language: Ada (GNAT)
"          $Id: gnat.vim 314 2006-07-18 17:11:31Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-07-18 19:11:31 +0200 (Di, 18 Jul 2006) $
"      Version: 3.3
"    $Revision: 314 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/compiler/gnat.vim $
"      History: 24.05.2006 MK Unified Headers
"		16.07.2006 MK Ada-Mode as vim-ball
"    Help Page: compiler-gnat
"------------------------------------------------------------------------------

if exists("g:loaded_gnat_autoload") || version < 700
    finish
else
   function gnat#Make () dict
      let &l:makeprg	   = eval (self.Make_Command)
      let &l:errorformat = self.Error_Format
      wall
      make
      copen
      set wrap
      wincmd W
   endfunction gnat#Make

   function gnat#Find () dict
      execute "!" . eval (self.Find_Command)
   endfunction gnat#Find

   function gnat#Tags () dict
      execute "!" . eval (self.Tags_Command)
      edit tags
      call gnat#Insert_Tags_Header ()
      update
      quit
   endfunction gnat#Tags

   function gnat#Set_Project_File () dict
      if strlen (self.Project_File) > 0
	 let self.Project_File = browse (0, 'GNAT Project File?', '', self.Project_File)
      else
         let self.Project_File = browse (0, 'GNAT Project File?', '', 'default.gpr')
      endif
      return
   endfunction gnat#Set_Project_File

   function gnat#New ()
      return {
	 \ 'Make'	      : function ('gnat#Make'),
	 \ 'Find'	      : function ('gnat#Find'),
	 \ 'Tags'	      : function ('gnat#Tags'),
	 \ 'Set_Project_File' : function ('gnat#Set_Project_File'),
	 \ 'Project_File'     : strlen (v:servername) > 0
				 \ ? v:servername . 'gpr.'
				 \ : ''
	 \ 'Make_Command'     : '"gnat make -P " . gnat.Project_File . " "',
	 \ 'Find_Program'     : '"gnat find -P " . gnat.Project_File . " "',
	 \ 'Tags_Command'     : '"gnat xref -P " . gnat.Project_File . " -v  *.AD*"',
	 \ 'Error_Format'     : '%f:%l:%c: %trror: %m,'   .
			\ '%f:%l:%c: %tarning: %m,' .
			\ '%f:%l:%c: (%ttyle) %m'}
   endfunction gnat#New

   function gnat#Insert_Tags_Header ()
      1insert
!_TAG_FILE_FORMAT       1       /extended format; --format=1 will not append ;" to lines/
!_TAG_FILE_SORTED       1       /0=unsorted, 1=sorted, 2=foldcase/
!_TAG_PROGRAM_AUTHOR    AdaCore /info@adacore.com/
!_TAG_PROGRAM_NAME      gnatxref        //
!_TAG_PROGRAM_URL       http://www.adacore.com  /official site/
!_TAG_PROGRAM_VERSION   5.05w   //
.
      return
   endfunction gnat#Insert_Tags_Header

   let g:loaded_gnat_autoload=1
   finish
endif

"------------------------------------------------------------------------------
"   Copyright (C) 2006  Martin Krischik
"
"   This program is free software; you can redistribute it and/or
"   modify it under the terms of the GNU General Public License
"   as published by the Free Software Foundation; either version 2
"   of the License, or (at your option) any later version.
"
"   This program is distributed in the hope that it will be useful,
"   but WITHOUT ANY WARRANTY; without even the implied warranty of
"   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"   GNU General Public License for more details.
"
"   You should have received a copy of the GNU General Public License
"   along with this program; if not, write to the Free Software
"   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
"------------------------------------------------------------------------------
" vim: textwidth=78 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
