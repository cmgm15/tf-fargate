/*
 * Reference: https://github.com/cmgm15/tf-s3-remote-state/blob/master/README.md
 */

module "remote_state" {
  source = "github.com/cmgm15/tf-s3-remote-state?ref=1.0.0"

  owner       = var.owner
  application = var.app
  tags        = var.tags
}
