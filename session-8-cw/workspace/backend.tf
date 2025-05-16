terraform {
  backend "s3" {
    bucket  = "tf-session-backend-bucket-beka"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    workspace_key_prefix = "workspace"
  }
}



// terraform.workspace = current workspace name

// each workspace will have its own terraform.tfstate file 
// in S3 bucket: 
// workspace/dev/tfstate