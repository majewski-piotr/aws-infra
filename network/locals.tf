locals {
  availability_zones = toset(["a", "b"])
  cidr = {
    private = {
      vpc = "10.0.0.0/24"
      subnet = {
        a = "10.0.0.0/25"
        b = "10.0.0.128/25"
      }
    }
    public = {
      vpc = "10.0.1.0/24"
      subnet = {
        a = "10.0.1.0/25"
        b = "10.0.1.128/25"
      }
    }
  }
}
