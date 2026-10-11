resource "oci_load_balancer_path_route_set" "load_balancer_path_route_sets" {
  for_each = var.load_balancer_path_route_sets

  load_balancer_id = each.value.load_balancer_id
  name             = each.value.name

  dynamic "path_routes" {
    for_each = each.value.path_routes
    content {
      backend_set_name = path_routes.value.backend_set_name
      path             = path_routes.value.path
      path_match_type {
        match_type = path_routes.value.path_match_type.match_type
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

