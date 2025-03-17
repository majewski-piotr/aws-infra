
resource "awscc_ec2_network_insights_access_scope" "public_access_scope" {
  match_paths = [{
    destination = {
      resource_statement = {
        resources = local.subnet_ids_public
      }
    }
  }]
  exclude_paths = [{
    destination = {
      packet_header_statement = {
        protocols         = ["tcp"]
        destination_ports = ["80"]
      }
    }
  }]

  tags = [{
    key   = "Name"
    value = "public subnets access scope excluding allowed edge subnets"
  }]
}

resource "awscc_ec2_network_insights_access_scope_analysis" "public_analysis" {
  network_insights_access_scope_id = awscc_ec2_network_insights_access_scope.public_access_scope.id

  tags = [{
    key   = "Name"
    value = "public-subnet-analysis"
  }]

  lifecycle {
    replace_triggered_by = [
     null_resource.remote_state_trigger,
      awscc_ec2_network_insights_access_scope.public_access_scope.match_paths,
      awscc_ec2_network_insights_access_scope.public_access_scope.exclude_paths
    ]
  }
}

output "public_analysis_status" {
  description = "Status of the network insights access scope analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.public_analysis.status
}

output "public_analysis_findings" {
  description = "Findings from the network insights access scope analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.public_analysis.findings_found
}

output "public_analysis_start_date" {
  description = "Start date of the analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.public_analysis.start_date
}

output "public_analysis_end_date" {
  description = "End date of the analysis."
  value       = awscc_ec2_network_insights_access_scope_analysis.public_analysis.end_date
}
