# --------------------------------------------------
# Outputs for Project 6: Device Farm + Appium
# Prints useful info after terraform apply
# --------------------------------------------------


output "device_farm_project_arn" {
    description = "ARN of the Device Farm Project"
    value = aws_devicefarm_project.main.arn
}

output "device_pool_arn" {
    description = "ARN of the Android device pool"
    value = aws_devicefarm_device_pool.android.arn
}