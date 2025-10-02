```abap
projection;
strict ( 2 );

use draft;

use side effects;

define behavior for zsk_c_pr_hdr //alias <alias_name>
{
  use create;
  use update;
  use delete;

  use action Edit;
  use action Activate;
  use action Discard;
  use action Resume;
  use action Prepare;

  use association _Item { create; with draft; }
}

define behavior for ZSK_C_PR_ITM //alias <alias_name>
{
  use update;
  use delete;

  use association _Header { with draft; }

}
```