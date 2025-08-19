%let pgm=utl-get-text-file-attributes-and-window-file-properties-powershell-python-sas;

%stop_submission;

Get text file attributes and window file properties powershell python sas

Correction: removed comma in utl_varcount macro RJD 2025-08-19

github
https://tinyurl.com/48kcestb
https://github.com/rogerjdeangelis/utl-get-text-file-attributes-and-window-file-properties-powershell-python-sas

CONTENTS
  1 python windows only properties
  2 powershell windows properties
  3 sas file properties cross platform
  4 metamacs and file macros

    Individual macros loaded into your autocall library

    FILE ATTRIBUTES

    Flat files
    utl_CreateTime
    utl_filesize
    utl_LastModified

    SAS DATASET VARIABLE ATTRIBUTES

    utl_varcount
    utl_varfmt
    utl_varifmt
    utl_varlabel
    utl_varlen
    utl_varnum
    utl_vartype

 5 related repos

SOAPBOX ON
   I could not get any of these to work

    PERL to get properties set by sas
    Powershell to get properties set by sas
    R to get properties set by sas

   2 There may be an issue with category property.
     SAS populates it but python cannot read it?

SOAPBOX OFF

Related (see end of message for longer list)
github
https://tinyurl.com/3axaxt8s
https://github.com/rogerjdeangelis/utl-adding-attributes-sas-macros-for-vartype-varlength-varfmt-varinfmt-varlabel-varcount-varnum

related repo
https://tinyurl.com/4av38mca
https://github.com/rogerjdeangelis/utl-perl-write-and-read-meta-data-saved-in-the-windows-file-properties-details-panel


/*****************************************************************************************************  ***********************/
/* INPUT                             |PROCESS                                                    | OUTPUT (SAS ASSIGNED META) */
/* =====                             |=======                                                    | ========================== */
/*                                   |                                                           |                            */
/* d:/xls/roger.xlsx                 |1 PYTHON WINDOWS ONLY PROPERTIES                           | PYTHON                     */
/*                                   |                                                           | File      d:\xls\roger.xlsx*/
/*   +----------------------+        |                                                           | Author    Roger DeAngelis  */
/*   |     A   |  B   |  C  |        |%utlfkil(d:/txt/meta.txt);                                 | Title     Demographics     */
/*   +----------------------+        |                                                           | Subject   Pubs             */
/* 1 |  NAME   | SEX  | AGE |        |%utl_pybegin;                                              | Tags      SDTM clinical    */
/*   +---------+------+-----+        |parmcards4;                                                | Category                   */
/* 2 | ALFRED  |  M   | 14  |        |import win32com.client                                     | Comments  Rogers Comments  */
/*   +---------+------+-----+        |import os                                                  | Name      roger.xlsx       */
/* 3 | ALICE   |  F   | 15  |        |                                                           |                            */
/*   +---------+------+-----+        |def get_file_properties(file_path):                        | SAS                        */
/*                                   | properties = {}                                           |                            */
/*                                   |                                                           | File     d:\xls\roger.xlsx */
/*  _______________________________  | # Check if file exists                                    | Author   Roger DeAngelis   */
/* |                              |  | if not os.path.exists(file_path):                         | Title    Demographics      */
/* |                              |  |     return properties                                     | Subject  Pubs              */
/* | select properties > details  |  |                                                           | Tags     SDTM clinical     */
/* |                              |  | shell = win32com.client.Dispatch("Shell.Application")     | Category                   */
/* | Roger.xlsx Properties        |  | dir_path = os.path.dirname(file_path)                     | Comments Rogers Comments   */
/* |                              |  |                                                           | Name     roger.xlsx        */
/* | +----------------------------|  | # Handle root directory case                              |                            */
/* | |General|Security|Details|   |  | if dir_path == "":                                        |                            */
/* | +----------------------------|  |   dir_path = os.path.splitdrive(file_path)[0] + "\\"      |                            */
/* |                              |  |                                                           |                            */
/* | Property    Value            |  | folder = shell.NameSpace(dir_path)                        |                            */
/* |                              |  |                                                           |                            */
/* | Discription -----------------|  | if folder is None:                                        |                            */
/* |                              |  |     return properties                                     |                            */
/* | Title:      Demographics     |  |                                                           |                            */
/* | Subject:    Pubs             |  | file_item=folder.ParseName(os.path.basename(file_path))   |                            */
/* | Tags:       SDTM clinical    |  |                                                           |                            */
/* | Categories  Demographics     |  | if file_item:                                             |                            */
/* | Comments:   Rogers Comments  |  |  prop_map = {                                             |                            */
/* | Author:     Roger Deangelis  |  |      'Author': 20,   # System.Author                      |                            */
/* |                              |  |      'Title': 21,    # System.Title                       |                            */
/* |______________________________|  |      'Subject': 22,  # System.Subject                     |                            */
/*                                   |      'Tags': 18,     # System.Keywords                    |                            */
/* %utlfkil(d:/xls/roger.xlsx);      |      'Category': 26, # System.Category                    |                            */
/*                                   |      'Comments': 24, # System.Comment                     |                            */
/* ods excel file="d:/xls/roger.xlsx"|      'Name': 0,      # System.FileName                    |                            */
/*                                   |  }                                                        |                            */
/*   Title    = "Demographics"       |                                                           |                            */
/*   Subject  = "Pubs"               |  for name, index in prop_map.items():                     |                            */
/*   Keywords = "SDTM clinical"      |      try:                                                 |                            */
/*   Category = "Demographics"       |          value = folder.GetDetailsOf(file_item, index)    |                            */
/*   Comments = "Rogers Comments"    |          properties[name] = value if value else ''        |                            */
/*   Author="Roger DeAngelis";       |      except Exception:                                    |                            */
/*                                   |          properties[name] = ''                            |                            */
/* ods excel                         |                                                           |                            */
/*  options(sheet_name="meta");      | return properties                                         |                            */
/* proc print data=sashelp.class     |                                                           |                            */
/*   (obs=2 keep=name sex age);      |# Define paths                                             |                            */
/* run;quit;                         |input_file = r"d:\xls\roger.xlsx"                          |                            */
/*                                   |output_file = r"d:\txt\meta.txt"                           |                            */
/* ods excel close;                  |                                                           |                            */
/*                                   |# Get properties                                           |                            */
/*                                   |properties = get_file_properties(input_file)               |                            */
/*                                   |                                                           |                            */
/*                                   |# Write results to file                                    |                            */
/*                                   |try:                                                       |                            */
/*                                   | with open(output_file, 'w', encoding='utf-8') as f:       |                            */
/*                                   |   # Write table header                                    |                            */
/*                                   |   f.write("{:<12} {}\n\n".format("PROPERTY", "VALUE"))    |                            */
/*                                   |                                                           |                            */
/*                                   |   # Write file path                                       |                            */
/*                                   |   f.write("{:<12} {}\n".format("File", input_file))       |                            */
/*                                   |                                                           |                            */
/*                                   |   # Write other properties                                |                            */
/*                                   |   prop_order = ['Author', 'Title', 'Subject' \            |                            */
/*                                   |   ,'Tags', 'Category', 'Comments', 'Name']                |                            */
/*                                   |   for prop in prop_order:                                 |                            */
/*                                   |       value = properties.get(prop, '')                    |                            */
/*                                   |       f.write("{:<12} {}\n".format(prop, value))          |                            */
/*                                   |                                                           |                            */
/*                                   | print(f"Successfully wrote properties to: {output_file}") |                            */
/*                                   |                                                           |                            */
/*                                   |except Exception as e:                                     |                            */
/*                                   |    print(f"Error writing to file: {e}")                   |                            */
/*                                   |                                                           |                            */
/*                                   |;;;;                                                       |                            */
/*                                   |%utl_pyend;                                                |                            */
/*                                   |                                                           |                            */
/*                                   |                                                           |                            */
/*                                   |----------------------------------------------------------------------------------------*/
/*                                   |                                        |                                               */
/*                                   |2 POWERSHELL WINDOWS PROPERTIES         | PSPath           : FileSystem:D:\xls\have.xlsx*/
/*                                   |===============================         | PSParentPath     : FileSystem:D:\xls          */
/*                                   |                                        | PSChildName      : have.xlsx                  */
/*                                   |proc datasets lib=work nolist nodetails;| PSDrive          : D                          */
/*                                   | delete want;                           | PSProvider       : PowerShell.Core\FileSystem */
/*                                   |run;quit;                               | Mode             : -a----                     */
/*                                   |                                        | VersionInfo      : File: D:\xls\have.xlsx     */
/*                                   |*--- clear clipboard ---;               | BaseName         : have                       */
/*                                   |                                        | Target           : {}                         */
/*                                   |%utl_emptyclipbrd;                      | LinkType         :                            */
/*                                   |                                        | Name             : have.xlsx                  */
/*                                   |%utl_submit_ps64('                      | Length           : 6387                       */
/*                                   |Get-ItemProperty                        | DirectoryName    : D:\xls                     */
/*                                   |   -Path d:\xls\have.xlsx               | Directory        : D:\xls                     */
/*                                   |   | Format-List                        | IsReadOnly       : False                      */
/*                                   |   -Property * | clip;                  | Exists           : True                       */
/*                                   |');                                     | FullName         : D:\xls\have.xlsx           */
/*                                   |                                        | Extension        : .xlsx                      */
/*                                   |filename clp clipbrd;                   | CreationTime     : 3/29/2024 4:24:04 PM       */
/*                                   |data want ;                             | CreationTimeUtc  : 3/29/2024 11:24:04 PM      */
/*                                   |   length var $20 val $60;              | LastAccessTime   : 8/14/2025 10:43:10 AM      */
/*                                   |   infile clp;                          | LastAccessTimeUtc: 8/14/2025 5:43:10 PM       */
/*                                   |   input;                               | LastWriteTime    : 3/31/2025 2:15:17 PM       */
/*                                   |   var=scan(_infile_,1,':');            | LastWriteTimeUtc : 3/31/2025 9:15:17 PM       */
/*                                   |   val=compbl(scan(_infile_,2,':'));    | Attributes       : Archive                    */
/*                                   |   if not missing(var);                 |                                               */
/*                                   |run;quit;                               |                                               */
/*                                   |                                        |                                               */
/*                                   |----------------------------------------------------------------------------------------*/
/*                                   |3 SAS FILE PROPERTIES CROSS PLATFORM                       |                            */
/*                                   |====================================                       |                            */
/*                                   |                                                           |                            */
/*                                   |see below for macros                                       |                            */
/*                                   |                                                           |                            */
/*                                   |                                                           |                            */
/*                                   |%put SIZE: %utl_filesize(d:\xls\have.xlsx) bytes;          | SIZE: 6387 bytes           */
/*                                   |                                                           |                            */
/*                                   |                                                           |                            */
/*                                   |%put CREATED :%utl_CreateTime(d:\xls\have.xlsx);           | CREATED :29Mar2024:16:24:04*/
/*                                   |                                                           |                            */
/*                                   |                                                           |                            */
/*                                   |%put MODIFIED: %utl_LastModified(d:\xls\have.xlsx);        | MODIFIED:31Mar2025:14:15:17*/
/*                                   |                                                           |                            */
/*                                   |                                                           |                            */
/*                                   |----------------------------------------------------------------------------------------*/
/*                                   |4 UNPACK MTEAMACS AND ADD FILEMACROS                       |                            */
/*                                   |====================================                       |                            */
/*                                   |                                                           |                            */
/*                                   |see below                                                  |                            */
/*                                   |                                                           |                            */
/******************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

%utlfkil(d:/xls/roger.xlsx);

ods excel file="d:/xls/roger.xlsx"

  Title    = "Demographics"
  Subject  = "Pubs"
  Keywords = "SDTM clinical"
  Category = "Demographics"
  Comments = "Rogers Comments"
  Author="Roger DeAngelis";

ods excel
 options(sheet_name="meta");
proc print data=sashelp.class
  (obs=2 keep=name sex age);
run;quit;

ods excel close;

/****************************************************************************************************************************/
/* d:/xls/roger.xlsx                                                                                                        */
/*                                                                                                                          */
/*   +----------------------+                                                                                               */
/*   |     A   |  B   |  C  |                                                                                               */
/*   +----------------------+                                                                                               */
/* 1 |  NAME   | SEX  | AGE |                                                                                               */
/*   +---------+------+-----+                                                                                               */
/* 2 | ALFRED  |  M   | 14  |                                                                                               */
/*   +---------+------+-----+                                                                                               */
/* 3 | ALICE   |  F   | 15  |                                                                                               */
/*   +---------+------+-----+                                                                                               */
/*                                                                                                                          */
/*  _______________________________                                                                                         */
/* |                              |                                                                                         */
/* |                              |                                                                                         */
/* | select properties > details  |                                                                                         */
/* |                              |                                                                                         */
/* | Roger.xlsx Properties        |                                                                                         */
/* |                              |                                                                                         */
/* | +----------------------------|                                                                                         */
/* | |General|Security|Details|   |                                                                                         */
/* | +----------------------------|                                                                                         */
/* |                              |                                                                                         */
/* | Property    Value            |                                                                                         */
/* |                              |                                                                                         */
/* | Discription -----------------|                                                                                         */
/* |                              |                                                                                         */
/* | Title:      Demographics     |                                                                                         */
/* | Subject:    Pubs             |                                                                                         */
/* | Tags:       SDTM clinical    |                                                                                         */
/* | Categories  Demographics     |                                                                                         */
/* | Comments:   Rogers Comments  |                                                                                         */
/* | Author:     Roger Deangelis  |                                                                                         */
/* |                              |                                                                                         */
/* |______________________________|                                                                                         */
/****************************************************************************************************************************/

/*               _   _                                                                  _   _
/ |  _ __  _   _| |_| |__   ___  _ __    ___  __ _ ___  _ __  _ __ ___  _ __   ___ _ __| |_(_) ___  ___
| | | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` / __|| `_ \| `__/ _ \| `_ \ / _ \ `__| __| |/ _ \/ __|
| | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| \__ \| |_) | | | (_) | |_) |  __/ |  | |_| |  __/\__ \
|_| | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__,_|___/| .__/|_|  \___/| .__/ \___|_|   \__|_|\___||___/
    |_|    |___/                                       |_|             |_|

*/

%utlfkil(d:/txt/meta.txt);

%utl_pybegin;
parmcards4;
import win32com.client
import os

def get_file_properties(file_path):
 properties = {}

 # Check if file exists
 if not os.path.exists(file_path):
     return properties

 shell = win32com.client.Dispatch("Shell.Application")
 dir_path = os.path.dirname(file_path)

 # Handle root directory case
 if dir_path == "":
   dir_path = os.path.splitdrive(file_path)[0] + "\\"

 folder = shell.NameSpace(dir_path)

 if folder is None:
     return properties

 file_item=folder.ParseName(os.path.basename(file_path))

 if file_item:
  prop_map = {
      'Author': 20,   # System.Author
      'Title': 21,    # System.Title
      'Subject': 22,  # System.Subject
      'Tags': 18,     # System.Keywords
      'Category': 26, # System.Category
      'Comments': 24, # System.Comment
      'Name': 0,      # System.FileName
  }

  for name, index in prop_map.items():
      try:
          value = folder.GetDetailsOf(file_item, index)
          properties[name] = value if value else ''
      except Exception:
          properties[name] = ''

 return properties

# Define paths
input_file = r"d:\xls\roger.xlsx"
output_file = r"d:\txt\meta.txt"

# Get properties
properties = get_file_properties(input_file)

# Write results to file
try:
 with open(output_file, 'w', encoding='utf-8') as f:
   # Write table header
   f.write("{:<12} {}\n\n".format("PROPERTY", "VALUE"))

   # Write file path
   f.write("{:<12} {}\n".format("File", input_file))

   # Write other properties
   prop_order = ['Author', 'Title', 'Subject' \
   ,'Tags', 'Category', 'Comments', 'Name']
   for prop in prop_order:
       value = properties.get(prop, '')
       f.write("{:<12} {}\n".format(prop, value))

 print(f"Successfully wrote properties to: {output_file}")

except Exception as e:
    print(f"Error writing to file: {e}")

;;;;
%utl_pyend;

/****************************************************************************************************************************/
/* OUTPUT (SAS ASSIGNED META)                                                                                               */
/* ==========================                                                                                               */
/*                                                                                                                          */
/* PYTHON                                                                                                                   */
/* File      d:\xls\roger.xlsx                                                                                              */
/* Author    Roger DeAngelis                                                                                                */
/* Title     Demographics                                                                                                   */
/* Subject   Pubs                                                                                                           */
/* Tags      SDTM clinical                                                                                                  */
/* Category                                                                                                                 */
/* Comments  Rogers Comments                                                                                                */
/* Name      roger.xlsx                                                                                                     */
/*                                                                                                                          */
/* SAS                                                                                                                      */
/*                                                                                                                          */
/* File     d:\xls\roger.xlsx                                                                                               */
/* Author   Roger DeAngelis                                                                                                 */
/* Title    Demographics                                                                                                    */
/* Subject  Pubs                                                                                                            */
/* Tags     SDTM clinical                                                                                                   */
/* Category                                                                                                                 */
/* Comments Rogers Comments                                                                                                 */
/* Name     roger.xlsx                                                                                                      */
/****************************************************************************************************************************/
                                                                                          _   _
/*___                                     _          _ _  _ __  _ __ ___  _ __   ___ _ __| |_(_) ___  ___
|___ \   _ __   _____      _____ _ __ ___| |__   ___| | || `_ \| `__/ _ \| `_ \ / _ \ `__| __| |/ _ \/ __|
  __) | | `_ \ / _ \ \ /\ / / _ \ `__/ __| `_ \ / _ \ | || |_) | | | (_) | |_) |  __/ |  | |_| |  __/\__ \
 / __/  | |_) | (_) \ V  V /  __/ |  \__ \ | | |  __/ | || .__/|_|  \___/| .__/ \___|_|   \__|_|\___||___/
|_____| | .__/ \___/ \_/\_/ \___|_|  |___/_| |_|\___|_|_||_|             |_|
        |_|
*/

proc datasets lib=work nolist nodetails;
 delete want;
run;quit;

*--- clear clipboard ---;

%utl_emptyclipbrd;

%utl_submit_ps64('
Get-ItemProperty
   -Path d:\xls\have.xlsx
   | Format-List
   -Property * | clip;
');

filename clp clipbrd;
data want ;
   length var $20 val $60;
   infile clp;
   input;
   var=scan(_infile_,1,':');
   val=compbl(scan(_infile_,2,':'));
   if not missing(var);
run;quit;

/**************************************************************************************************************************/
/* WORK.WANT total obs=25                                                                                                 */
/*  VAR                  VAL                                                                                              */
/*                                                                                                                        */
/*  PSPath               Microsoft.PowerShell.Core\FileSystem                                                             */
/*  PSParentPath         Microsoft.PowerShell.Core\FileSystem                                                             */
/*  PSChildName          have.xlsx                                                                                        */
/*  PSDrive              D                                                                                                */
/*  PSProvider           Microsoft.PowerShell.Core\FileSystem                                                             */
/*  Mode                 -a----                                                                                           */
/*  VersionInfo          File                                                                                             */
/*  BaseName             have                                                                                             */
/*  Target               {}                                                                                               */
/*  LinkType                                                                                                              */
/*  Name                 have.xlsx                                                                                        */
/*  Length               6387                                                                                             */
/*  DirectoryName        D                                                                                                */
/*  Directory            D                                                                                                */
/*  IsReadOnly           False                                                                                            */
/*  Exists               True                                                                                             */
/*  FullName             D                                                                                                */
/*  Extension            .xlsx                                                                                            */
/*  CreationTime         3/29/2024 4                                                                                      */
/*  CreationTimeUtc      3/29/2024 11                                                                                     */
/*  LastAccessTime       8/14/2025 3                                                                                      */
/*  LastAccessTimeUtc    8/14/2025 10                                                                                     */
/*  LastWriteTime        3/31/2025 2                                                                                      */
/*  LastWriteTimeUtc     3/31/2025 9                                                                                      */
/*  Attributes           Archive                                                                                          */
/**************************************************************************************************************************/

/*____                                                   _   _
|___ /   ___  __ _ ___   _ __  _ __ ___  _ __   ___ _ __| |_(_) ___  ___
  |_ \  / __|/ _` / __| | `_ \| `__/ _ \| `_ \ / _ \ `__| __| |/ _ \/ __|
 ___) | \__ \ (_| \__ \ | |_) | | | (_) | |_) |  __/ |  | |_| |  __/\__ \
|____/  |___/\__,_|___/ | .__/|_|  \___/| .__/ \___|_|   \__|_|\___||___/
                        |_|             |_|
see macros below
*/

%put SIZE: %utl_filesize(d:\xls\have.xlsx) bytes;
%put CREATED :%utl_CreateTime(d:\xls\have.xlsx);
%put MODIFIED: %utl_LastModified(d:\xls\have.xlsx);

/**************************************************************************************************************************/
/*| SIZE: 6387 bytes                                                                                                      */
/*| CREATED :29Mar2024:16:24:04                                                                                           */
/*| MODIFIED:31Mar2025:14:15:17                                                                                           */
/**************************************************************************************************************************/

/*  _                    _                                                       _    __ _ _
| || |    _ __ ___   ___| |_ ___  __ _ _ __ ___   __ _  ___ ___   __ _ _ __   __| |  / _(_) | ___   _ __ ___   __ _  ___ _ __ ___  ___
| || |_  | `_ ` _ \ / _ \ __/ _ \/ _` | `_ ` _ \ / _` |/ __/ __| / _` | `_ \ / _` | | |_| | |/ _ \ | `_ ` _ \ / _` |/ __| `__/ _ \/ __|
|__   _| | | | | | |  __/ ||  __/ (_| | | | | | | (_| | (__\__ \| (_| | | | | (_| | |  _| | |  __/ | | | | | | (_| | (__| | | (_) \__ \
   |_|   |_| |_| |_|\___|\__\___|\__,_|_| |_| |_|\__,_|\___|___/ \__,_|_| |_|\__,_| |_| |_|_|\___| |_| |_| |_|\__,_|\___|_|  \___/|___/
                                 _       _     _             _   _        _ _           _
 ___  __ _ ___  __   ____ _ _ __(_) __ _| |__ | | ___   __ _| |_| |_ _ __(_) |__  _   _| |_ ___  ___
/ __|/ _` / __| \ \ / / _` | `__| |/ _` | `_ \| |/ _ \ / _` | __| __| `__| | `_ \| | | | __/ _ \/ __|
\__ \ (_| \__ \  \ V / (_| | |  | | (_| | |_) | |  __/| (_| | |_| |_| |  | | |_) | |_| | ||  __/\__ \
|___/\__,_|___/   \_/ \__,_|_|  |_|\__,_|_.__/|_|\___| \__,_|\__|\__|_|  |_|_.__/ \__,_|\__\___||___/

utl_varcount.sas
utl_varfmt.sas
utl_varifmt.sas
utl_varlabel.sas
utl_varlen.sas
utl_varnum.sas
utl_vartype.sas
*/

* edit for your autocall library;
%let oto=c:/oto/utl_var;

filename ft15f001 "&oto.num.sas";
parmcards4;
%macro utl_varnum(dsn,var)/des="Variable position mnumber in pdv";
  %local dsid posv rc;
   %let dsid = %sysfunc(open(&dsn,i));
   %let posv = %sysfunc(varnum(&dsid,&var));
   %sysfunc(varnum(&dsid,&var));
   %let rc = %sysfunc(close(&dsid));
%mend utl_varnum;
;;;;
run;quit;

filename ft15f001 "&oto.type.sas";
parmcards4;
%macro utl_vartype(dsn,var)/des="Variable type returns N or C";
  %local dsid posv rc;
   %let dsid = %sysfunc(open(&dsn,i));
   %let posv = %sysfunc(varnum(&dsid,&var));
   %sysfunc(vartype(&dsid,&posv))
   %let rc = %sysfunc(close(&dsid));
%mend utl_vartype;
;;;;
run;quit;

filename ft15f001 "&oto.len.sas";
parmcards4;
%macro utl_varlen(dsn,var)/des="Variable length";
  %local dsid posv rc;
   %let dsid = %sysfunc(open(&dsn,i));
   %let posv = %sysfunc(varnum(&dsid,&var));
   %sysfunc(varlen(&dsid,&posv))
   %let rc = %sysfunc(close(&dsid));
%mend utl_varlen;
;;;;
run;quit;

filename ft15f001 "&oto.fmt.sas";
parmcards4;
%macro utl_varfmt(dsn,var)/des="Variable format";
  %local dsid posv rc;
   %let dsid = %sysfunc(open(&dsn,i));
   %let posv = %sysfunc(varnum(&dsid,&var));
   %sysfunc(varfmt(&dsid,&posv))
   %let rc = %sysfunc(close(&dsid));
%mend utl_varfmt;
;;;;
run;quit;

filename ft15f001 "&oto.ifmt.sas";
parmcards4;
%macro utl_varinfmt(dsn,var)/des="Variable informat";
  %local dsid posv rc;
   %let dsid = %sysfunc(open(&dsn,i));
   %let posv = %sysfunc(varnum(&dsid,&var));
   %sysfunc(varinfmt(&dsid,&posv))
   %let rc = %sysfunc(close(&dsid));
%mend utl_varinfmt;
;;;;
run;quit;

filename ft15f001 "&oto.label.sas";
parmcards4;
%macro utl_varlabel(dsn,var)/des="Variable label";
  %local dsid posv rc;
   %let dsid = %sysfunc(open(&dsn,i));
   %let posv = %sysfunc(varnum(&dsid,&var));
   %sysfunc(varlabel(&dsid,&posv))
   %let rc = %sysfunc(close(&dsid));
%mend utl_varlabel;
;;;;
run;quit;

filename ft15f001 "&oto.count.sas";
parmcards4;
%macro utl_varcount(dsn)/des="Number of variables";
  %local dsid posv rc;
    %let dsid = %sysfunc(open(&dsn,i));
    %sysfunc(attrn(&dsid,NVARS))
    %let rc = %sysfunc(close(&dsid));
%mend utl_varcount;
;;;;
run;quit;

/*__ _ _              _   _        _ _           _
 / _(_) | ___    __ _| |_| |_ _ __(_) |__  _   _| |_ ___  ___
| |_| | |/ _ \  / _` | __| __| `__| | `_ \| | | | __/ _ \/ __|
|  _| | |  __/ | (_| | |_| |_| |  | | |_) | |_| | ||  __/\__ \
|_| |_|_|\___|  \__,_|\__|\__|_|  |_|_.__/ \__,_|\__\___||___/

utl_CreateTime.sas
utl_filesize.sas
utl_LastModified.sas
*/

* edit for your autocall library;
%let oto=c:/oto/utl_;

filename ft15f001 "&oto.filesize.sas";
parmcards4;
%macro utl_filesize(filename);
  %local rc fid fidc Bytes ans;
  %let rc=%sysfunc(filename(onefile,&filename));
  %let fid=%sysfunc(fopen(&onefile));
  %if &fid ne 0 %then %do;
     %let ans=%sysfunc(finfo(&fid,File Size (bytes)));
  %end;
  %else %do;
      %let ans= &filename could not be open.;
  %end;
  %let fidc=%sysfunc(fclose(&fid));
  %let rc=%sysfunc(filename(onefile));
  &ans
%mend utl_filesize;
;;;;
run;quit;

filename ft15f001 "&oto.CreateTime.sas";
parmcards4;
%macro utl_CreateTime(filename);
  %local rc fid fidc Bytes ans;
  %let rc=%sysfunc(filename(onefile,&filename));
  %let fid=%sysfunc(fopen(&onefile));
  %if &fid ne 0 %then %do;
     %let ans=%sysfunc(finfo(&fid,Create Time));
  %end;
  %else %do;
      %let ans= &filename could not be open.;
  %end;
  %let fidc=%sysfunc(fclose(&fid));
  %let rc=%sysfunc(filename(onefile));
  &ans
%mend utl_CreateTime;
;;;;
run;quit;

filename ft15f001 "&oto.LastModified.sas";
parmcards4;
%macro utl_LastModified(filename);
  %local rc fid fidc Bytes ans;
  %let rc=%sysfunc(filename(onefile,&filename));
  %let fid=%sysfunc(fopen(&onefile));
  %if &fid ne 0 %then %do;
     %let ans=%sysfunc(finfo(&fid,Last Modified));
  %end;
  %else %do;
      %let ans= &filename could not be open.;
  %end;
  %let fidc=%sysfunc(fclose(&fid));
  %let rc=%sysfunc(filename(onefile));
  &ans
%mend utl_LastModified;
;;;;
run;quit;

/*___             _       _           _
| ___|   _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
|___ \  | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
 ___) | | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
|____/  |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                                  |_|
*/

https://github.com/rogerjdeangelis/utl_file_and_directory_utilities_for_all_operating_systems
https://github.com/rogerjdeangelis/utl-Delete-all-files-in-a-directory-with-a-specified-extension-ie-delete-excel-files
https://github.com/rogerjdeangelis/utl-concatenate-files-in-a-github-directory-and-create-a-book-with-title-toc-pages
https://github.com/rogerjdeangelis/utl-copying-binary-files-from-one-directory-to-another-using-a-data-_null_
https://github.com/rogerjdeangelis/utl-copying-windows-image-backup-tree-and-files-and-how-to-copy-paste-long-file-and-directory-names
https://github.com/rogerjdeangelis/utl-delete-all-files-in-a-directory-then-delete-the-directory
https://github.com/rogerjdeangelis/utl-identify-the-most-recent-file-in-the-directory-and-copy-the-file-to-another-folder
https://github.com/rogerjdeangelis/utl-import-all-excel-workskkets-and-named-ranges--in-all-workbooks-in-a-directory
https://github.com/rogerjdeangelis/utl-indirect-addressing-indexed-lookup-in-sas-r-and-python-sql-multi-language
https://github.com/rogerjdeangelis/utl-nice-snippet-of-code-to-create-a-table-with-a-directory-of_files
https://github.com/rogerjdeangelis/utl-recursively-get-all-SAS-column-for-tables-in-multiple-directories-and-subdirectories
https://github.com/rogerjdeangelis/utl-sas-directing-proc-printto-to-the-windows-clipboard-and-gsubmit
https://github.com/rogerjdeangelis/utl-space-used-by-parent-folders-on-c-drive-without-subdirectory-for-file-space
https://github.com/rogerjdeangelis/utl_combining_all_pdf_files_in_a_directory
https://github.com/rogerjdeangelis/utl_excel_import_entire_directory
https://github.com/rogerjdeangelis/utl_find_most_recent_log_file_in_a_directory_of_log_files
https://github.com/rogerjdeangelis/utl-seven-algorithms-for-importing-exporting-csv-files-without-proc-export-impor

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
