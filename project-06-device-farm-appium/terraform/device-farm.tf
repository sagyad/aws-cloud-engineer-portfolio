# --------------------------------------------------
# Device Farm resources for Project 6
# Creates Device Farm project and device pool
# Device Farm only available in us-west-2
# --------------------------------------------------

resource "aws_devicefarm_project" "main" {
  name = var.project_name
}

resource "aws_devicefarm_device_pool" "android" {
  name        = "${var.project_name}-android-pool"
  project_arn = aws_devicefarm_project.main.arn
  description = "Android device pool for Appium Tests"

  rule {
    attribute = "PLATFORM"
    operator  = "EQUALS"
    value     = "\"ANDROID\""
  }
}