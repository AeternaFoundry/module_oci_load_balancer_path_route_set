variable "load_balancer_path_route_sets" {
  description = <<EOT
Map of load_balancer_path_route_sets, attributes below
Required:
    - load_balancer_id
    - name
    - path_routes (block):
        - backend_set_name (required)
        - path (required)
        - path_match_type (required, block):
            - match_type (required)
Optional:
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    load_balancer_id = string
    name             = string
    path_routes = list(object({
      backend_set_name = string
      path             = string
      path_match_type = object({
        match_type = string
      })
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.load_balancer_path_route_sets : (
        length(v.path_routes) >= 1
      )
    ])
    error_message = "Each path_routes list must contain at least 1 items"
  }
}

