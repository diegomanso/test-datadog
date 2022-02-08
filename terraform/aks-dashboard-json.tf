resource "datadog_dashboard_json" "dashboard_json" {
  dashboard = <<EOF
{
  "title": "Kubernetes - POC",
  "description": "Kubernetes POC for Pollinate test",
  "widgets": [
    {
      "id": 0,
      "layout": {
        "x": 151,
        "y": 57,
        "width": 43,
        "height": 24
      },
      "definition": {
        "title": "Most memory-intensive pods",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "4h"
        },
        "type": "toplist",
        "requests": [
          {
            "q": "top(sum:kubernetes.memory.usage{$scope,$deployment,$statefulset,$replicaset,$daemonset,$cluster,$namespace,!pod_name:no_pod,$label,$service,$node} by {pod_name}, 10, 'mean', 'desc')",
            "style": {
              "palette": "cool"
            }
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 1,
      "layout": {
        "x": 107,
        "y": 57,
        "width": 43,
        "height": 24
      },
      "definition": {
        "title": "Most CPU-intensive pods",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "4h"
        },
        "type": "toplist",
        "requests": [
          {
            "q": "top(sum:kubernetes.cpu.usage.total{$scope,$deployment,$statefulset,$replicaset,$daemonset,$cluster,$namespace,!pod_name:no_pod,$label,$service,$node} by {pod_name}, 10, 'mean', 'desc')",
            "style": {
              "palette": "warm"
            }
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 2,
      "layout": {
        "x": 0,
        "y": 0,
        "width": 23,
        "height": 15
      },
      "definition": {
        "type": "image",
        "url": "/static/images/screenboard/integrations/kubernetes.jpg",
        "sizing": "zoom"
      }
    },
    {
      "id": 3,
      "layout": {
        "x": 80,
        "y": 0,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Kubelets up",
        "title_size": "16",
        "title_align": "center",
        "time": {
          "live_span": "10m"
        },
        "type": "check_status",
        "check": "kubernetes.kubelet.check",
        "grouping": "cluster",
        "group_by": [],
        "tags": [
          "$scope",
          "$node",
          "$label"
        ]
      }
    },
    {
      "id": 4,
      "layout": {
        "x": 50,
        "y": 91,
        "width": 16,
        "height": 14
      },
      "definition": {
        "title": "Pods Available",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.deployment.replicas_available{$scope,$deployment,$cluster,$label,$namespace,$service,$node}",
            "aggregator": "avg",
            "conditional_formats": [
              {
                "comparator": ">",
                "palette": "green_on_white",
                "value": 0
              }
            ]
          }
        ],
        "autoscale": true,
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 5,
      "layout": {
        "x": 67,
        "y": 91,
        "width": 37,
        "height": 14
      },
      "definition": {
        "title": "Pods available",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.deployment.replicas_available{$scope,$deployment,$service,$label,$cluster,$namespace,$node} by {kube_deployment}",
            "style": {
              "palette": "green",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 6,
      "layout": {
        "x": 50,
        "y": 76,
        "width": 16,
        "height": 14
      },
      "definition": {
        "title": "Pods desired",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.deployment.replicas_desired{$scope,$deployment,$cluster,$label,$namespace,$service,$node}",
            "aggregator": "avg",
            "conditional_formats": [
              {
                "custom_fg_color": "#6a53a1",
                "comparator": ">",
                "palette": "custom_text",
                "value": 0
              }
            ]
          }
        ],
        "autoscale": true,
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 7,
      "layout": {
        "x": 67,
        "y": 76,
        "width": 37,
        "height": 14
      },
      "definition": {
        "title": "Pods desired",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.deployment.replicas_desired{$scope,$deployment,$cluster,$label,$namespace,$service,$node} by {kube_deployment}",
            "style": {
              "palette": "purple",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 8,
      "layout": {
        "x": 50,
        "y": 106,
        "width": 16,
        "height": 14
      },
      "definition": {
        "title": "Pods unavailable",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.deployment.replicas_unavailable{$scope,$deployment,$cluster,$label,$namespace,$service,$node}",
            "aggregator": "avg",
            "conditional_formats": [
              {
                "comparator": ">",
                "palette": "yellow_on_white",
                "value": 0
              },
              {
                "comparator": "<=",
                "palette": "green_on_white",
                "value": 0
              }
            ]
          }
        ],
        "autoscale": true,
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 9,
      "layout": {
        "x": 67,
        "y": 106,
        "width": 37,
        "height": 14
      },
      "definition": {
        "title": "Pods unavailable",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.deployment.replicas_unavailable{$scope,$deployment,$service,$label,$cluster,$namespace,$node} by {kube_deployment}",
            "style": {
              "palette": "orange",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 10,
      "layout": {
        "x": 37,
        "y": 16,
        "width": 67,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "Pods",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 11,
      "layout": {
        "x": 107,
        "y": 16,
        "width": 87,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "[Resource utilization](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/#toc-resource-utilization6)",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 12,
      "layout": {
        "x": 0,
        "y": 34,
        "width": 36,
        "height": 37
      },
      "definition": {
        "time": {
          "live_span": "1w"
        },
        "type": "event_stream",
        "query": "sources:kubernetes $node",
        "tags_execution": "and",
        "event_size": "s"
      }
    },
    {
      "id": 13,
      "layout": {
        "x": 37,
        "y": 38,
        "width": 33,
        "height": 15
      },
      "definition": {
        "title": "Running pods per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.pods.running{$scope,$deployment,$statefulset,$replicaset,$daemonset,$label,$cluster,$namespace,$service,$node} by {host}",
            "style": {
              "palette": "dog_classic",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "yaxis": {
          "include_zero": true,
          "scale": "linear",
          "label": "",
          "min": "auto",
          "max": "auto"
        },
        "custom_links": []
      }
    },
    {
      "id": 14,
      "layout": {
        "x": 151,
        "y": 22,
        "width": 43,
        "height": 18
      },
      "definition": {
        "title": "Memory usage per node",
        "title_size": "16",
        "title_align": "left",
        "type": "hostmap",
        "requests": {
          "fill": {
            "q": "sum:kubernetes.memory.usage{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
          }
        },
        "no_metric_hosts": false,
        "no_group_hosts": true,
        "scope": [
          "$scope",
          "$node",
          "$label",
          "$kube_deployment",
          "$kube_namespace"
        ],
        "custom_links": [],
        "style": {
          "palette": "hostmap_blues",
          "palette_flip": false
        }
      }
    },
    {
      "id": 15,
      "layout": {
        "x": 107,
        "y": 121,
        "width": 43,
        "height": 16
      },
      "definition": {
        "title": "Network errors per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.network.rx_errors{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}",
            "style": {
              "palette": "warm"
            },
            "display_type": "bars"
          },
          {
            "q": "sum:kubernetes.network.tx_errors{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}",
            "style": {
              "palette": "warm"
            },
            "display_type": "bars"
          },
          {
            "q": "sum:kubernetes.network_errors{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}",
            "style": {
              "palette": "warm",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "bars"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 16,
      "layout": {
        "x": 107,
        "y": 41,
        "width": 43,
        "height": 15
      },
      "definition": {
        "title": "Sum Kubernetes CPU requests per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.cpu.requests{$scope,$deployment,$statefulset,$replicaset,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}",
            "style": {
              "palette": "warm"
            },
            "display_type": "line"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 17,
      "layout": {
        "x": 151,
        "y": 41,
        "width": 43,
        "height": 15
      },
      "definition": {
        "title": "Sum Kubernetes memory requests per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.memory.requests{$scope,$deployment,$statefulset,$replicaset,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}",
            "style": {
              "palette": "cool"
            },
            "display_type": "line"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 18,
      "layout": {
        "x": 107,
        "y": 82,
        "width": 87,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "Disk I/O & Network",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 19,
      "layout": {
        "x": 107,
        "y": 88,
        "width": 43,
        "height": 16
      },
      "definition": {
        "title": "Network in per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.network.rx_bytes{$scope,$deployment,$statefulset,$replicaset,$daemonset,$cluster,$namespace,$label,$service,$node} by {host}",
            "style": {
              "palette": "purple"
            },
            "display_type": "line"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 20,
      "layout": {
        "x": 107,
        "y": 105,
        "width": 43,
        "height": 15
      },
      "definition": {
        "title": "Network out per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.network.tx_bytes{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}",
            "style": {
              "palette": "green"
            },
            "display_type": "line"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 21,
      "layout": {
        "x": 0,
        "y": 16,
        "width": 36,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "[Events](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/#toc-correlate-with-events10)",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 22,
      "layout": {
        "x": 0,
        "y": 22,
        "width": 36,
        "height": 9
      },
      "definition": {
        "title": "Number of Kubernetes events per node",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "1d"
        },
        "type": "event_timeline",
        "query": "sources:kubernetes $node",
        "tags_execution": "and"
      }
    },
    {
      "id": 23,
      "layout": {
        "x": 107,
        "y": 22,
        "width": 43,
        "height": 18
      },
      "definition": {
        "title": "CPU utilization per node",
        "title_size": "16",
        "title_align": "left",
        "type": "hostmap",
        "requests": {
          "fill": {
            "q": "sum:kubernetes.cpu.usage.total{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {host}"
          }
        },
        "no_metric_hosts": false,
        "no_group_hosts": true,
        "scope": [
          "$scope",
          "$node",
          "$label",
          "$kube_deployment",
          "$kube_namespace"
        ],
        "custom_links": [],
        "style": {
          "palette": "YlOrRd",
          "palette_flip": false
        }
      }
    },
    {
      "id": 24,
      "layout": {
        "x": 95,
        "y": 0,
        "width": 16,
        "height": 15
      },
      "definition": {
        "type": "note",
        "content": "Read our\n[Monitoring guide for Kubernetes](https://www.datadoghq.com/blog/monitoring-kubernetes-era/).\n \nCheck [the agent documentation](https://docs.datadoghq.com/agent/kubernetes/) if some of the graphs are empty.",
        "background_color": "yellow",
        "font_size": "14",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "left"
      }
    },
    {
      "id": 25,
      "layout": {
        "x": 0,
        "y": 76,
        "width": 16,
        "height": 14
      },
      "definition": {
        "title": "Desired",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.daemonset.desired{$scope,$daemonset,$cluster,$label,$namespace,$service,$node}",
            "aggregator": "last",
            "conditional_formats": [
              {
                "custom_fg_color": "#6a53a1",
                "comparator": ">",
                "palette": "custom_text",
                "value": 0
              }
            ]
          }
        ],
        "autoscale": true,
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 26,
      "layout": {
        "x": 17,
        "y": 76,
        "width": 32,
        "height": 14
      },
      "definition": {
        "title": "Pods desired",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.daemonset.desired{$scope,$daemonset,$service,$namespace,$label,$cluster,$node} by {kube_daemon_set}",
            "style": {
              "palette": "purple",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 27,
      "layout": {
        "x": 0,
        "y": 91,
        "width": 16,
        "height": 14
      },
      "definition": {
        "title": "Ready",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.daemonset.ready{$scope,$daemonset,$cluster,$label,$namespace,$service,$node}",
            "aggregator": "last",
            "conditional_formats": [
              {
                "comparator": ">",
                "palette": "green_on_white",
                "value": 0
              },
              {
                "comparator": "<=",
                "palette": "red_on_white",
                "value": 0
              }
            ]
          }
        ],
        "autoscale": true,
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 28,
      "layout": {
        "x": 80,
        "y": 8,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Kubelet Ping",
        "title_size": "16",
        "title_align": "center",
        "time": {
          "live_span": "10m"
        },
        "type": "check_status",
        "check": "kubernetes.kubelet.check.ping",
        "grouping": "cluster",
        "group_by": [],
        "tags": [
          "*",
          "$node",
          "$label",
          "$scope"
        ]
      }
    },
    {
      "id": 29,
      "layout": {
        "x": 50,
        "y": 127,
        "width": 54,
        "height": 14
      },
      "definition": {
        "title": "Container states",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.container.running{$scope,$deployment,$statefulset,$replicaset,$daemonset,$service,$namespace,$label,$cluster,$node}",
            "style": {
              "palette": "dog_classic",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "line"
          },
          {
            "q": "sum:kubernetes_state.container.waiting{$scope,$deployment,$statefulset,$replicaset,$daemonset,$service,$namespace,$label,$cluster,$node}",
            "style": {
              "palette": "warm",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "line"
          },
          {
            "q": "sum:kubernetes_state.container.terminated{$scope,$deployment,$statefulset,$replicaset,$daemonset,$service,$namespace,$label,$cluster,$node}",
            "style": {
              "palette": "grey",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "line"
          },
          {
            "q": "sum:kubernetes_state.container.ready{$scope,$deployment,$statefulset,$replicaset,$daemonset,$service,$namespace,$label,$cluster,$node}",
            "style": {
              "palette": "grey",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "line"
          }
        ],
        "yaxis": {
          "include_zero": true,
          "scale": "linear",
          "label": "",
          "min": "auto",
          "max": "auto"
        },
        "custom_links": []
      }
    },
    {
      "id": 30,
      "layout": {
        "x": 17,
        "y": 112,
        "width": 32,
        "height": 14
      },
      "definition": {
        "title": "Ready",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.replicaset.replicas_ready{$scope,$service,$namespace,$deployment,$replicaset,$label,$cluster,$node} by {kube_replica_set}",
            "style": {
              "palette": "purple",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 31,
      "layout": {
        "x": 17,
        "y": 127,
        "width": 32,
        "height": 14
      },
      "definition": {
        "title": "Not ready",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.replicaset.replicas_desired{$scope,$service,$namespace,$deployment,$replicaset,$label,$cluster,$node} by {kube_replica_set}-sum:kubernetes_state.replicaset.replicas_ready{$scope,$service,$namespace,$deployment,$replicaset,$label,$cluster,$node} by {kube_replica_set}",
            "style": {
              "palette": "orange",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 32,
      "layout": {
        "x": 151,
        "y": 105,
        "width": 43,
        "height": 15
      },
      "definition": {
        "title": "Disk reads per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.io.read_bytes{$scope,$service,$namespace,$deployment,$statefulset,$replicaset,$daemonset,$label,$cluster,$node} by {host}",
            "style": {
              "palette": "grey",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "line"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 33,
      "layout": {
        "x": 151,
        "y": 88,
        "width": 43,
        "height": 16
      },
      "definition": {
        "title": "Disk writes per node",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.io.write_bytes{$scope,$service,$namespace,$deployment,$statefulset,$replicaset,$daemonset,$label,$cluster,$node} by {host}",
            "style": {
              "palette": "grey",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "line"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 34,
      "layout": {
        "x": 0,
        "y": 70,
        "width": 49,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "DaemonSets",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 35,
      "layout": {
        "x": 50,
        "y": 70,
        "width": 54,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "Deployments",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 36,
      "layout": {
        "x": 0,
        "y": 106,
        "width": 49,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "ReplicaSets",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 37,
      "layout": {
        "x": 50,
        "y": 121,
        "width": 54,
        "height": 5
      },
      "definition": {
        "type": "note",
        "content": "Containers",
        "background_color": "gray",
        "font_size": "18",
        "text_align": "center",
        "show_tick": false,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 38,
      "layout": {
        "x": 0,
        "y": 112,
        "width": 16,
        "height": 14
      },
      "definition": {
        "title": "Ready",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.replicaset.replicas_ready{$scope,$deployment,$replicaset,$cluster,$label,$namespace,$service,$node}",
            "aggregator": "last",
            "conditional_formats": [
              {
                "custom_fg_color": "#6a53a1",
                "comparator": ">",
                "palette": "custom_text",
                "value": 0
              }
            ]
          }
        ],
        "autoscale": true,
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 39,
      "layout": {
        "x": 0,
        "y": 127,
        "width": 16,
        "height": 14
      },
      "definition": {
        "title": "Not ready",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.replicaset.replicas_desired{$scope,$deployment,$replicaset,$service,$namespace,$label,$cluster,$node}-sum:kubernetes_state.replicaset.replicas_ready{$scope,$deployment,$replicaset,$service,$namespace,$label,$cluster,$node}",
            "aggregator": "last",
            "conditional_formats": [
              {
                "custom_fg_color": "#6a53a1",
                "comparator": ">",
                "palette": "yellow_on_white",
                "value": 0
              }
            ]
          }
        ],
        "autoscale": true,
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 40,
      "layout": {
        "x": 17,
        "y": 91,
        "width": 32,
        "height": 14
      },
      "definition": {
        "title": "Pods ready",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.daemonset.ready{$scope,$daemonset,$service,$namespace,$label,$cluster,$node} by {kube_daemon_set}",
            "style": {
              "palette": "green",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 41,
      "layout": {
        "x": 37,
        "y": 22,
        "width": 33,
        "height": 15
      },
      "definition": {
        "title": "Running pods per namespace",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.pods.running{$scope,$cluster,$namespace,$deployment,$statefulset,$replicaset,$daemonset,$label,$node,$service} by {kube_cluster_name,kube_namespace}",
            "style": {
              "palette": "dog_classic",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "area"
          }
        ],
        "yaxis": {
          "include_zero": true,
          "scale": "linear",
          "label": "",
          "min": "auto",
          "max": "auto"
        },
        "custom_links": [
          {
            "link": "https://www.google.com?search={{kube_namespace.value}}",
            "label": "Search Namespace on Google"
          }
        ]
      }
    },
    {
      "id": 42,
      "layout": {
        "x": 37,
        "y": 54,
        "width": 33,
        "height": 15
      },
      "definition": {
        "title": "Pods in bad phase by namespaces",
        "title_size": "16",
        "title_align": "left",
        "type": "toplist",
        "requests": [
          {
            "q": "top(sum:kubernetes_state.pod.status_phase{$scope,$cluster,$namespace,$deployment,$statefulset,$replicaset,$daemonset,!pod_phase:running,!pod_phase:succeeded,$label,$node,$service} by {kube_cluster_name,kube_namespace,pod_phase}, 100, 'last', 'desc')",
            "conditional_formats": [
              {
                "comparator": ">",
                "palette": "white_on_red",
                "value": 0
              },
              {
                "comparator": "<=",
                "palette": "white_on_green",
                "value": 0
              }
            ]
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 43,
      "layout": {
        "x": 71,
        "y": 54,
        "width": 33,
        "height": 15
      },
      "definition": {
        "title": "CrashloopBackOff by Pod",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes_state.container.waiting{$cluster,$namespace,$deployment,$statefulset,$replicaset,$daemonset,reason:crashloopbackoff,$scope,$daemonset,$label,$node,$service} by {pod_name}",
            "style": {
              "palette": "dog_classic",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "bars"
          }
        ],
        "yaxis": {
          "include_zero": true,
          "scale": "linear",
          "label": "",
          "min": "auto",
          "max": "auto"
        },
        "markers": [
          {
            "label": "y = 0",
            "value": "y = 0",
            "display_type": "ok dashed"
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 44,
      "layout": {
        "x": 71,
        "y": 22,
        "width": 33,
        "height": 15
      },
      "definition": {
        "title": "Pods running by namespace",
        "title_size": "16",
        "title_align": "left",
        "type": "toplist",
        "requests": [
          {
            "q": "top(sum:kubernetes.pods.running{$scope,$namespace,$cluster,$deployment,$statefulset,$replicaset,$daemonset,$label,$node,$service} by {kube_cluster_name,kube_namespace}, 100, 'max', 'desc')",
            "conditional_formats": [
              {
                "comparator": ">",
                "palette": "white_on_red",
                "value": 2000
              },
              {
                "comparator": ">",
                "palette": "white_on_yellow",
                "value": 1500
              },
              {
                "comparator": "<=",
                "palette": "white_on_green",
                "value": 3000
              }
            ]
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 45,
      "layout": {
        "x": 71,
        "y": 38,
        "width": 33,
        "height": 15
      },
      "definition": {
        "title": "Pods in ready state by node",
        "title_size": "16",
        "title_align": "left",
        "type": "toplist",
        "requests": [
          {
            "q": "top(sum:kubernetes_state.pod.ready{$scope,$cluster,$namespace,$deployment,$statefulset,$replicaset,$daemonset,condition:true,$label,$node,$service} by {kubernetes_cluster,host,nodepool}, 10, 'last', 'desc')",
            "conditional_formats": [
              {
                "comparator": "<=",
                "palette": "white_on_green",
                "value": 24
              },
              {
                "comparator": ">",
                "palette": "white_on_red",
                "value": 32
              },
              {
                "comparator": ">",
                "palette": "white_on_yellow",
                "value": 24
              }
            ]
          }
        ],
        "custom_links": []
      }
    },
    {
      "id": 46,
      "layout": {
        "x": 24,
        "y": 0,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Clusters",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "count_nonzero(avg:kubernetes.pods.running{$scope,$label,$node,$service,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster} by {kube_cluster_name})",
            "aggregator": "avg"
          }
        ],
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 47,
      "layout": {
        "x": 38,
        "y": 0,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Namespaces",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "count_nonzero(avg:kubernetes.pods.running{$scope,$label,$node,$service,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster} by {kube_cluster_name,kube_namespace})",
            "aggregator": "avg"
          }
        ],
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 48,
      "layout": {
        "x": 52,
        "y": 8,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Deployments",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "count_nonzero(avg:kubernetes_state.deployment.replicas{$scope,$label,$node,$service,$deployment,$replicaset,$namespace,$cluster} by {kube_cluster_name,kube_namespace,kube_deployment})",
            "aggregator": "avg"
          }
        ],
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 49,
      "layout": {
        "x": 52,
        "y": 0,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Services",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.service.count{$scope,$label,$node,$service,$namespace,$cluster}",
            "aggregator": "avg"
          }
        ],
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 50,
      "layout": {
        "x": 38,
        "y": 8,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "DaemonSets",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "count_nonzero(avg:kubernetes_state.daemonset.desired{$scope,$label,$node,$service,$daemonset,$namespace,$cluster} by {kube_cluster_name,kube_namespace,kube_daemon_set})",
            "aggregator": "avg"
          }
        ],
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 51,
      "layout": {
        "x": 24,
        "y": 8,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Nodes",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes_state.node.count{$scope,$label,$node,$service,$namespace,$cluster}",
            "aggregator": "avg"
          }
        ],
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 52,
      "layout": {
        "x": 66,
        "y": 0,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Pods",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes.pods.running{$scope,$label,$node,$service,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster}",
            "aggregator": "avg"
          }
        ],
        "custom_links": [
          {
            "link": "https://app.datadoghq.com/screen/integration/30322/kubernetes-pods-overview",
            "label": "View Pods overview"
          }
        ],
        "precision": 0
      }
    },
    {
      "id": 53,
      "layout": {
        "x": 66,
        "y": 8,
        "width": 13,
        "height": 7
      },
      "definition": {
        "title": "Containers",
        "title_size": "16",
        "title_align": "left",
        "type": "query_value",
        "requests": [
          {
            "q": "sum:kubernetes.containers.running{$scope,$label,$node,$service,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster}",
            "aggregator": "avg"
          }
        ],
        "custom_links": [],
        "precision": 0
      }
    },
    {
      "id": 54,
      "layout": {
        "x": 151,
        "y": 121,
        "width": 43,
        "height": 16
      },
      "definition": {
        "title": "Network errors per pod",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "legend_size": "0",
        "time": {
          "live_span": "4h"
        },
        "type": "timeseries",
        "requests": [
          {
            "q": "sum:kubernetes.network.rx_errors{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {pod_name}",
            "style": {
              "palette": "warm",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "bars"
          },
          {
            "q": "sum:kubernetes.network.tx_errors{$scope,$deployment,$statefulset,$replicaset,$daemonset,$namespace,$cluster,$label,$service,$node} by {pod_name}",
            "style": {
              "palette": "warm",
              "line_type": "solid",
              "line_width": "normal"
            },
            "display_type": "bars"
          }
        ],
        "yaxis": {
          "include_zero": true,
          "scale": "linear",
          "label": "",
          "min": "auto",
          "max": "auto"
        },
        "custom_links": []
      }
    }
  ],
  "template_variables": [
    {
      "name": "scope",
      "default": "*",
      "available_values": []
    },
    {
      "name": "cluster",
      "default": "*",
      "prefix": "kube_cluster_name",
      "available_values": []
    },
    {
      "name": "namespace",
      "default": "*",
      "prefix": "kube_namespace",
      "available_values": []
    },
    {
      "name": "deployment",
      "default": "*",
      "prefix": "kube_deployment",
      "available_values": []
    },
    {
      "name": "daemonset",
      "default": "*",
      "prefix": "kube_daemon_set",
      "available_values": []
    },
    {
      "name": "statefulset",
      "default": "*",
      "prefix": "kube_stateful_set",
      "available_values": []
    },
    {
      "name": "replicaset",
      "default": "*",
      "prefix": "kube_replica_set",
      "available_values": []
    },
    {
      "name": "service",
      "default": "*",
      "prefix": "kube_service",
      "available_values": []
    },
    {
      "name": "node",
      "default": "*",
      "prefix": "node",
      "available_values": []
    },
    {
      "name": "label",
      "default": "*",
      "prefix": "label",
      "available_values": []
    }
  ],
  "layout_type": "free",
  "is_read_only": false,
  "notify_list": [],
  "id": "3zg-u2b-ur3"
}
EOF
}
