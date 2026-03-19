terraform {
  backend "gcs" {
    bucket = "tf-state-lab3-chaus-mariia-11"
    prefix = "env/dev/var-11.tfstate"
  }
}