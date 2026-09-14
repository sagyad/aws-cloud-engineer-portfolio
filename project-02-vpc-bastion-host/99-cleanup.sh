#!/usr/bin/env bash
# ============================================
# 99-cleanup.sh
# Terminate EC2 instances to stop billing
# Run this when done testing!
# ============================================

aws ec2 terminate-instances --instance-ids i-018f72a391fd4b900 i-0d5fc7b699fef3a94
