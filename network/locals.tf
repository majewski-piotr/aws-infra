locals {
  availability_zones = toset(["a", "b"])
  cidr = {
    private = {
      #00001010.00000000.00000000|00000000
      vpc = "10.0.0.0/24"
      subnet = {
        compute = {
          #00001010.00000000.00000000.00|000000
          a = "10.0.0.0/26"
          #00001010.00000000.00000000.01|000000
          b = "10.0.0.64/26"
        }
        edge = {
          #00001010.00000000.00000000.10000|000
          a = "10.0.0.128/29"
          #00001010.00000000.00000000.10001|000
          b = "10.0.0.136/29"
        }
      }
    }
    public = {
      #00001010.00000000.00000001|00000000
      vpc = "10.0.1.0/24"
      subnet = {
        #00001010.00000000.00000001.0|0000000
        a = "10.0.1.0/25"
        #00001010.00000000.00000001.1|0000000
        b = "10.0.1.128/25"
      }
    }
  }
}
