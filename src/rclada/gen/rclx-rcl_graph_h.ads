pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with rclx.rmw_names_and_types_h;
limited with rclx.rcl_node_h;
with rclx.rcl_allocator_h;
with Interfaces.C.Extensions;
with rclx.rcl_types_h;
limited with rclx.rcutils_types_string_array_h;
with Interfaces.C.Strings;
with rclx.stddef_h;
limited with rclx.rcl_client_h;

package rclx.rcl_graph_h is

   --  unsupported macro: rcl_get_zero_initialized_names_and_types rmw_get_zero_initialized_names_and_types
  -- Copyright 2016-2017 Open Source Robotics Foundation, Inc.
  -- Licensed under the Apache License, Version 2.0 (the "License");
  -- you may not use this file except in compliance with the License.
  -- You may obtain a copy of the License at
  --     http://www.apache.org/licenses/LICENSE-2.0
  -- Unless required by applicable law or agreed to in writing, software
  -- distributed under the License is distributed on an "AS IS" BASIS,
  -- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  -- See the License for the specific language governing permissions and
  -- limitations under the License.
   subtype rcl_names_and_types_t is rclx.rmw_names_and_types_h.rmw_names_and_types_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:35

  --/ Return a list of topic names and their types.
  --*
  -- * This function returns a list of topic names in the ROS graph and their types.
  -- *
  -- * The node parameter must not be `NULL`, and must point to a valid node.
  -- *
  -- * The topic_names_and_types parameter must be allocated and zero initialized.
  -- * The topic_names_and_types is the output for this function, and contains
  -- * allocated memory.
  -- * Therefore, it should be passed to rcl_names_and_types_fini() when
  -- * it is no longer needed.
  -- * Failing to do so will result in leaked memory.
  -- *
  -- * There may be some demangling that occurs when listing the topics from the
  -- * middleware implementation.
  -- * If the no_demangle argument is true, then this will be avoided and the
  -- * topics will be returned as they appear to the middleware.
  -- *
  -- * \see rmw_get_topic_names_and_types for more details on no_demangle
  -- *
  -- * The returned names are not automatically remapped by this function.
  -- * Attempting to create publishers or subscribers using names returned by this function may not
  -- * result in the desired topic name being used depending on the remap rules in use.
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Maybe [1]
  -- * <i>[1] implementation may need to protect the data structure with a lock</i>
  -- *
  -- * \param[in] node the handle to the node being used to query the ROS graph
  -- * \param[in] allocator allocator to be used when allocating space for strings
  -- * \param[in] no_demangle if true, list all topics without any demangling
  -- * \param[out] topic_names_and_types list of topic names and their types
  -- * \return `RCL_RET_OK` if the query was successful, or
  -- * \return `RCL_RET_NODE_INVALID` if the node is invalid, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_get_topic_names_and_types
     (node : access constant rclx.rcl_node_h.rcl_node_t;
      allocator : access rclx.rcl_allocator_h.rcl_allocator_t;
      no_demangle : Extensions.bool;
      topic_names_and_types : access rcl_names_and_types_t) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:84
   pragma Import (C, rcl_get_topic_names_and_types, "rcl_get_topic_names_and_types");

  --/ Return a list of service names and their types.
  --*
  -- * This function returns a list of service names in the ROS graph and their types.
  -- *
  -- * The node parameter must not be `NULL`, and must point to a valid node.
  -- *
  -- * The service_names_and_types parameter must be allocated and zero initialized.
  -- * The service_names_and_types is the output for this function, and contains
  -- * allocated memory.
  -- * Therefore, it should be passed to rcl_names_and_types_fini() when
  -- * it is no longer needed.
  -- * Failing to do so will result in leaked memory.
  -- *
  -- * The returned names are not automatically remapped by this function.
  -- * Attempting to create clients or services using names returned by this function may not result in
  -- * the desired service name being used depending on the remap rules in use.
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Maybe [1]
  -- * <i>[1] implementation may need to protect the data structure with a lock</i>
  -- *
  -- * \param[in] node the handle to the node being used to query the ROS graph
  -- * \param[in] allocator allocator to be used when allocating space for strings
  -- * \param[out] service_names_and_types list of service names and their types
  -- * \return `RCL_RET_OK` if the query was successful, or
  -- * \return `RCL_RET_NODE_INVALID` if the node is invalid, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_get_service_names_and_types
     (node : access constant rclx.rcl_node_h.rcl_node_t;
      allocator : access rclx.rcl_allocator_h.rcl_allocator_t;
      service_names_and_types : access rcl_names_and_types_t) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:127
   pragma Import (C, rcl_get_service_names_and_types, "rcl_get_service_names_and_types");

  --/ Finalize a rcl_names_and_types_t object.
  --*
  -- * The object is populated when given to one of the rcl_get_*_names_and_types()
  -- * functions.
  -- * This function reclaims any resources allocated during population.
  -- *
  -- * The names_and_types parameter must not be `NULL`, and must point to an
  -- * already allocated rcl_names_and_types_t struct that was previously
  -- * passed to a successful rcl_get_*_names_and_types() function call.
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Yes
  -- *
  -- * \param[inout] names_and_types struct to be finalized
  -- * \return `RCL_RET_OK` if successful, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_names_and_types_fini (names_and_types : access rcl_names_and_types_t) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:158
   pragma Import (C, rcl_names_and_types_fini, "rcl_names_and_types_fini");

  --/ Return a list of available nodes in the ROS graph.
  --*
  -- * This function returns a list of nodes in the ROS graph.
  -- *
  -- * The node parameter must not be `NULL`, and must point to a valid node.
  -- *
  -- * The node_names parameter must be allocated and zero initialized.
  -- * The node_names is the output for this function, and contains
  -- * allocated memory.
  -- * Note that entries in the array might contain `NULL` value.
  -- * Use rcutils_get_zero_initialized_string_array() for initializing an empty
  -- * rcutils_string_array_t struct.
  -- * This node_names struct should therefore be passed to rcutils_string_array_fini()
  -- * when it is no longer needed.
  -- * Failing to do so will result in leaked memory.
  -- *
  -- * Example:
  -- *
  -- * ```c
  -- * rcutils_string_array_t node_names =
  -- *   rcutils_get_zero_initialized_string_array();
  -- * rcl_ret_t ret = rcl_get_node_names(node, &node_names);
  -- * if (ret != RCL_RET_OK) {
  -- *   // ... error handling
  -- * }
  -- * // ... use the node_names struct, and when done:
  -- * rcutils_ret_t rcutils_ret = rcutils_string_array_fini(&node_names);
  -- * if (rcutils_ret != RCUTILS_RET_OK) {
  -- *   // ... error handling
  -- * }
  -- * ```
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Maybe [1]
  -- * <i>[1] implementation may need to protect the data structure with a lock</i>
  -- *
  -- * \param[in] node the handle to the node being used to query the ROS graph
  -- * \param[in] allocator used to control allocation and deallocation of names
  -- * \param[out] node_names struct storing discovered node names.
  -- * \return `RCL_RET_OK` if the query was successful, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_get_node_names
     (node : access constant rclx.rcl_node_h.rcl_node_t;
      allocator : rclx.rcl_allocator_h.rcl_allocator_t;
      node_names : access rclx.rcutils_types_string_array_h.rcutils_string_array_t) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:210
   pragma Import (C, rcl_get_node_names, "rcl_get_node_names");

  --/ Return the number of publishers on a given topic.
  --*
  -- * This function returns the number of publishers on a given topic.
  -- *
  -- * The node parameter must not be `NULL`, and must point to a valid node.
  -- *
  -- * The topic_name parameter must not be `NULL`, and must not be an empty string.
  -- * It should also follow the topic name rules.
  -- * \todo TODO(wjwwood): link to the topic name rules.
  -- *
  -- * The count parameter must not be `NULL`, and must point to a valid bool.
  -- * The count parameter is the output for this function and will be set.
  -- *
  -- * In the event that error handling needs to allocate memory, this function
  -- * will try to use the node's allocator.
  -- *
  -- * The topic name is not automatically remapped by this function.
  -- * If there is a publisher created with topic name `foo` and remap rule `foo:=bar` then calling
  -- * this with `topic_name` set to `bar` will return a count of 1, and with `topic_name` set to `foo`
  -- * will return a count of 0.
  -- * /sa rcl_remap_topic_name()
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | No
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Maybe [1]
  -- * <i>[1] implementation may need to protect the data structure with a lock</i>
  -- *
  -- * \param[in] node the handle to the node being used to query the ROS graph
  -- * \param[in] topic_name the name of the topic in question
  -- * \param[out] count number of publishers on the given topic
  -- * \return `RCL_RET_OK` if the query was successful, or
  -- * \return `RCL_RET_NODE_INVALID` if the node is invalid, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_count_publishers
     (node : access constant rclx.rcl_node_h.rcl_node_t;
      topic_name : Interfaces.C.Strings.chars_ptr;
      count : access rclx.stddef_h.size_t) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:257
   pragma Import (C, rcl_count_publishers, "rcl_count_publishers");

  --/ Return the number of subscriptions on a given topic.
  --*
  -- * This function returns the number of subscriptions on a given topic.
  -- *
  -- * The node parameter must not be `NULL`, and must point to a valid node.
  -- *
  -- * The topic_name parameter must not be `NULL`, and must not be an empty string.
  -- * It should also follow the topic name rules.
  -- * \todo TODO(wjwwood): link to the topic name rules.
  -- *
  -- * The count parameter must not be `NULL`, and must point to a valid bool.
  -- * The count parameter is the output for this function and will be set.
  -- *
  -- * In the event that error handling needs to allocate memory, this function
  -- * will try to use the node's allocator.
  -- *
  -- * The topic name is not automatically remapped by this function.
  -- * If there is a subscriber created with topic name `foo` and remap rule `foo:=bar` then calling
  -- * this with `topic_name` set to `bar` will return a count of 1, and with `topic_name` set to `foo`
  -- * will return a count of 0.
  -- * /sa rcl_remap_topic_name()
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | No
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Maybe [1]
  -- * <i>[1] implementation may need to protect the data structure with a lock</i>
  -- *
  -- * \param[in] node the handle to the node being used to query the ROS graph
  -- * \param[in] topic_name the name of the topic in question
  -- * \param[out] count number of subscriptions on the given topic
  -- * \return `RCL_RET_OK` if the query was successful, or
  -- * \return `RCL_RET_NODE_INVALID` if the node is invalid, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_count_subscribers
     (node : access constant rclx.rcl_node_h.rcl_node_t;
      topic_name : Interfaces.C.Strings.chars_ptr;
      count : access rclx.stddef_h.size_t) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:304
   pragma Import (C, rcl_count_subscribers, "rcl_count_subscribers");

  --/ Check if a service server is available for the given service client.
  --*
  -- * This function will return true for is_available if there is a service server
  -- * available for the given client.
  -- *
  -- * The node parameter must not be `NULL`, and must point to a valid node.
  -- *
  -- * The client parameter must not be `NULL`, and must point to a valid client.
  -- *
  -- * The given client and node must match, i.e. the client must have been created
  -- * using the given node.
  -- *
  -- * The is_available parameter must not be `NULL`, and must point a bool variable.
  -- * The result of the check will be stored in the is_available parameter.
  -- *
  -- * In the event that error handling needs to allocate memory, this function
  -- * will try to use the node's allocator.
  -- *
  -- * <hr>
  -- * Attribute          | Adherence
  -- * ------------------ | -------------
  -- * Allocates Memory   | Yes
  -- * Thread-Safe        | No
  -- * Uses Atomics       | No
  -- * Lock-Free          | Maybe [1]
  -- * <i>[1] implementation may need to protect the data structure with a lock</i>
  -- *
  -- * \param[in] node the handle to the node being used to query the ROS graph
  -- * \param[in] client the handle to the service client being queried
  -- * \param[out] is_available set to true if there is a service server available, else false
  -- * \return `RCL_RET_OK` if the check was made successfully (regardless of the service readiness), or
  -- * \return `RCL_RET_NODE_INVALID` if the node is invalid, or
  -- * \return `RCL_RET_INVALID_ARGUMENT` if any arguments are invalid, or
  -- * \return `RCL_RET_ERROR` if an unspecified error occurs.
  --  

   function rcl_service_server_is_available
     (node : access constant rclx.rcl_node_h.rcl_node_t;
      client : access constant rclx.rcl_client_h.rcl_client_t;
      is_available : access Extensions.bool) return rclx.rcl_types_h.rcl_ret_t;  -- /home/jano/local/ros2/ros2_rolling/install/include/rcl/graph.h:347
   pragma Import (C, rcl_service_server_is_available, "rcl_service_server_is_available");

end rclx.rcl_graph_h;