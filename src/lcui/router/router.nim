import ../lcui

{.passL: "LCUIRouter.lib".}

const
  LCUI_ROUTER_VERSION* = "0.1.0"

type
  RouterLocationT* {.bycopy.} = object
    name*: cstring
    path*: cstring
    hash*: cstring
    params*: ptr RouterStringDictT
    query*: ptr RouterStringDictT
    normalized*: RouterBooleanT

  RouterRouteT* {.bycopy.} = object
    name*: cstring
    path*: cstring
    fullPath*: cstring
    hash*: cstring
    query*: ptr RouterStringDictT
    params*: ptr RouterStringDictT
    matched*: RouterLinkedlistT

  RouterRouteRecordT* {.bycopy.} = object
    name*: cstring
    path*: cstring
    parent*: ptr RouterRouteRecordT
    components*: ptr RouterStringDictT
    node*: RouterLinkedlistNodeT

  RouterHistoryT* {.bycopy.} = object
    index*: cint
    current*: ptr RouterRouteT
    routes*: RouterLinkedlistT
    watchers*: RouterLinkedlistT

  RouterConfigT* {.bycopy.} = object
    name*: cstring
    path*: cstring
    components*: ptr RouterStringDictT

  RouterMatcherT* {.bycopy.} = object
    nameMap*: ptr Dict
    pathMap*: ptr Dict
    pathList*: RouterLinkedlistT

  RouterWatcherT* {.bycopy.} = object
    data*: pointer
    callback*: RouterCallbackT
    node*: RouterLinkedlistNodeT

  RouterResolvedT* {.bycopy.} = object
    route*: ptr RouterRouteT
    location*: ptr RouterLocationT

  RouterT* {.bycopy.} = object
    name*: cstring
    linkActiveClass*: cstring
    linkExactActiveClass*: cstring
    matcher*: ptr RouterMatcherT
    history*: ptr RouterHistoryT

  RouterStringDictT* = Dict
  RouterLinkedlistT* = LinkedList
  RouterLinkedlistNodeT* = LinkedListNode
  RouterBooleanT* = uint8
  RouterCallbackT* = proc (a1: pointer; a2: ptr RouterRouteT; a3: ptr RouterRouteT) {.cdecl.}

proc routerStringDictCreate*(): ptr RouterStringDictT {.cdecl,
    importc: "router_string_dict_create".}
  ##  router string dict
proc routerStringDictDestroy*(dict: ptr RouterStringDictT) {.cdecl,
    importc: "router_string_dict_destroy".}
proc routerStringDictDelete*(dict: ptr RouterStringDictT; key: cstring) {.cdecl,
    importc: "router_string_dict_delete".}
proc routerStringDictSet*(dict: ptr RouterStringDictT; key: cstring; value: cstring): cint {.
    cdecl, importc: "router_string_dict_set".}
proc routerStringDictGet*(dict: ptr RouterStringDictT; key: cstring): cstring {.cdecl,
    importc: "router_string_dict_get".}
proc routerStringDictExtend*(target: ptr RouterStringDictT;
                            other: ptr RouterStringDictT): csize_t {.cdecl,
    importc: "router_string_dict_extend".}
proc routerStringDictDuplicate*(target: ptr RouterStringDictT): ptr RouterStringDictT {.
    cdecl, importc: "router_string_dict_duplicate".}
proc routerStringDictIncludes*(a: ptr RouterStringDictT; b: ptr RouterStringDictT): RouterBooleanT {.
    cdecl, importc: "router_string_dict_includes".}
proc routerStringDictEqual*(a: ptr RouterStringDictT; b: ptr RouterStringDictT): RouterBooleanT {.
    cdecl, importc: "router_string_dict_equal".}
proc routerPathFillParams*(path: cstring; params: ptr RouterStringDictT): cstring {.
    cdecl, importc: "router_path_fill_params".}
  ##  router utils
proc routerPathParseKey*(path: cstring; key: array[256, char]; keyLen: ptr csize_t): cstring {.
    cdecl, importc: "router_path_parse_key".}
proc routerPathParseKeys*(path: cstring; keys: ptr RouterLinkedlistT): csize_t {.cdecl,
    importc: "router_path_parse_keys".}
proc routerPathResolve*(relative: cstring; base: cstring; append: RouterBooleanT): cstring {.
    cdecl, importc: "router_path_resolve".}
proc routerParseQuery*(queryStr: cstring): ptr RouterStringDictT {.cdecl,
    importc: "router_parse_query".}
proc routerStringCompare*(a: cstring; b: cstring): cint {.cdecl,
    importc: "router_string_compare".}
proc routerPathCompare*(a: cstring; b: cstring): cint {.cdecl,
    importc: "router_path_compare".}
proc routerPathStartsWith*(path: cstring; subpath: cstring): RouterBooleanT {.cdecl,
    importc: "router_path_starts_with".}
proc routerIsSameRoute*(a: ptr RouterRouteT; b: ptr RouterRouteT): RouterBooleanT {.
    cdecl, importc: "router_is_same_route".}
proc routerIsIncludedRoute*(current: ptr RouterRouteT; target: ptr RouterRouteT): RouterBooleanT {.
    cdecl, importc: "router_is_included_route".}
proc routerConfigCreate*(): ptr RouterConfigT {.cdecl,
    importc: "router_config_create".}
  ##  router config
proc routerConfigDestroy*(config: ptr RouterConfigT) {.cdecl,
    importc: "router_config_destroy".}
proc routerConfigSetName*(config: ptr RouterConfigT; name: cstring) {.cdecl,
    importc: "router_config_set_name".}
proc routerConfigSetPath*(config: ptr RouterConfigT; path: cstring) {.cdecl,
    importc: "router_config_set_path".}
proc routerConfigSetComponent*(config: ptr RouterConfigT; name: cstring;
                              component: cstring) {.cdecl,
    importc: "router_config_set_component".}
proc routerLocationCreate*(name: cstring; path: cstring): ptr RouterLocationT {.cdecl,
    importc: "router_location_create".}
  ##  router location
proc routerLocationDestroy*(location: ptr RouterLocationT) {.cdecl,
    importc: "router_location_destroy".}
proc routerLocationSetName*(location: ptr RouterLocationT; name: cstring) {.cdecl,
    importc: "router_location_set_name".}
proc routerLocationDuplicate*(location: ptr RouterLocationT): ptr RouterLocationT {.
    cdecl, importc: "router_location_duplicate".}
proc routerLocationNormalize*(raw: ptr RouterLocationT; current: ptr RouterRouteT;
                             append: RouterBooleanT): ptr RouterLocationT {.cdecl,
    importc: "router_location_normalize".}
proc routerLocationSetParam*(location: ptr RouterLocationT; key: cstring;
                            value: cstring): cint {.cdecl,
    importc: "router_location_set_param".}
proc routerLocationGetParam*(location: ptr RouterLocationT; key: cstring): cstring {.
    cdecl, importc: "router_location_get_param".}
proc routerLocationSetQuery*(location: ptr RouterLocationT; key: cstring;
                            value: cstring): cint {.cdecl,
    importc: "router_location_set_query".}
proc routerLocationGetQuery*(location: ptr RouterLocationT; key: cstring): cstring {.
    cdecl, importc: "router_location_get_query".}
proc routerLocationGetPath*(location: ptr RouterLocationT): cstring {.cdecl,
    importc: "router_location_get_path".}
proc routerLocationStringify*(location: ptr RouterLocationT): cstring {.cdecl,
    importc: "router_location_stringify".}
proc routerRouteRecordCreate*(): ptr RouterRouteRecordT {.cdecl,
    importc: "router_route_record_create".}
  ##  router route record
proc routerRouteRecordDestroy*(record: ptr RouterRouteRecordT) {.cdecl,
    importc: "router_route_record_destroy".}
proc routerRouteRecordSetPath*(record: ptr RouterRouteRecordT; path: cstring) {.cdecl,
    importc: "router_route_record_set_path".}
proc routerRouteRecordGetComponent*(record: ptr RouterRouteRecordT; key: cstring): cstring {.
    cdecl, importc: "router_route_record_get_component".}
proc routerRouteCreate*(record: ptr RouterRouteRecordT;
                       location: ptr RouterLocationT): ptr RouterRouteT {.cdecl,
    importc: "router_route_create".}
  ##  router route
proc routerRouteDestroy*(route: ptr RouterRouteT) {.cdecl,
    importc: "router_route_destroy".}
proc routerRouteGetMatchedRecord*(route: ptr RouterRouteT; index: csize_t): ptr RouterRouteRecordT {.
    cdecl, importc: "router_route_get_matched_record".}
proc routerRouteGetFullPath*(route: ptr RouterRouteT): cstring {.cdecl,
    importc: "router_route_get_full_path".}
proc routerRouteGetPath*(route: ptr RouterRouteT): cstring {.cdecl,
    importc: "router_route_get_path".}
proc routerRouteGetHash*(route: ptr RouterRouteT): cstring {.cdecl,
    importc: "router_route_get_hash".}
proc routerRouteGetParam*(route: ptr RouterRouteT; key: cstring): cstring {.cdecl,
    importc: "router_route_get_param".}
proc routerRouteGetQuery*(route: ptr RouterRouteT; key: cstring): cstring {.cdecl,
    importc: "router_route_get_query".}
proc routerMatcherCreate*(): ptr RouterMatcherT {.cdecl,
    importc: "router_matcher_create".}
  ##  router matcher
proc routerMatcherDestroy*(matcher: ptr RouterMatcherT) {.cdecl,
    importc: "router_matcher_destroy".}
proc routerMatcherMatch*(matcher: ptr RouterMatcherT;
                        rawLocation: ptr RouterLocationT;
                        currentRoute: ptr RouterRouteT): ptr RouterRouteT {.cdecl,
    importc: "router_matcher_match".}
proc routerMatcherAddRouteRecord*(matcher: ptr RouterMatcherT;
                                 config: ptr RouterConfigT;
                                 parent: ptr RouterRouteRecordT): ptr RouterRouteRecordT {.
    cdecl, importc: "router_matcher_add_route_record".}
proc routerHistoryCreate*(): ptr RouterHistoryT {.cdecl,
    importc: "router_history_create".}
  ##  router history
proc routerHistoryDestroy*(history: ptr RouterHistoryT) {.cdecl,
    importc: "router_history_destroy".}
proc routerHistoryWatch*(history: ptr RouterHistoryT; callback: RouterCallbackT;
                        data: pointer): ptr RouterWatcherT {.cdecl,
    importc: "router_history_watch".}
proc routerHistoryUnwatch*(history: ptr RouterHistoryT; watcher: ptr RouterWatcherT) {.
    cdecl, importc: "router_history_unwatch".}
proc routerHistoryPush*(history: ptr RouterHistoryT; route: ptr RouterRouteT) {.cdecl,
    importc: "router_history_push".}
proc routerHistoryReplace*(history: ptr RouterHistoryT; route: ptr RouterRouteT) {.
    cdecl, importc: "router_history_replace".}
proc routerHistoryGo*(history: ptr RouterHistoryT; delta: cint) {.cdecl,
    importc: "router_history_go".}
proc routerHistoryGetIndex*(history: ptr RouterHistoryT): csize_t {.cdecl,
    importc: "router_history_get_index".}
proc routerHistoryGetLength*(history: ptr RouterHistoryT): csize_t {.cdecl,
    importc: "router_history_get_length".}
proc routerCreate*(name: cstring): ptr RouterT {.cdecl, importc: "router_create".}
  ##  router
proc routerDestroy*(router: ptr RouterT) {.cdecl, importc: "router_destroy".}
proc routerAddRouteRecord*(router: ptr RouterT; config: ptr RouterConfigT;
                          parent: ptr RouterRouteRecordT): ptr RouterRouteRecordT {.
    cdecl, importc: "router_add_route_record".}
proc routerMatch*(router: ptr RouterT; rawLocation: ptr RouterLocationT;
                 currentRoute: ptr RouterRouteT): ptr RouterRouteT {.cdecl,
    importc: "router_match".}
proc routerGetMatchedRouteRecord*(router: ptr RouterT; index: csize_t): ptr RouterRouteRecordT {.
    cdecl, importc: "router_get_matched_route_record".}
proc routerGetHistory*(router: ptr RouterT): ptr RouterHistoryT {.cdecl,
    importc: "router_get_history".}
proc routerWatch*(router: ptr RouterT; callback: RouterCallbackT; data: pointer): ptr RouterWatcherT {.
    cdecl, importc: "router_watch".}
proc routerUnwatch*(router: ptr RouterT; watcher: ptr RouterWatcherT) {.cdecl,
    importc: "router_unwatch".}
proc routerResolve*(router: ptr RouterT; location: ptr RouterLocationT;
                   append: RouterBooleanT): ptr RouterResolvedT {.cdecl,
    importc: "router_resolve".}
proc routerResolvedGetLocation*(resolved: ptr RouterResolvedT): ptr RouterLocationT {.
    cdecl, importc: "router_resolved_get_location".}
proc routerResolvedGetRoute*(resolved: ptr RouterResolvedT): ptr RouterRouteT {.cdecl,
    importc: "router_resolved_get_route".}
proc routerResolvedDestroy*(resolved: ptr RouterResolvedT) {.cdecl,
    importc: "router_resolved_destroy".}
proc routerGetCurrentRoute*(router: ptr RouterT): ptr RouterRouteT {.cdecl,
    importc: "router_get_current_route".}
proc routerPush*(router: ptr RouterT; location: ptr RouterLocationT) {.cdecl,
    importc: "router_push".}
proc routerReplace*(router: ptr RouterT; location: ptr RouterLocationT) {.cdecl,
    importc: "router_replace".}
proc routerGo*(router: ptr RouterT; delta: cint) {.cdecl, importc: "router_go".}
proc routerBack*(router: ptr RouterT) {.cdecl, importc: "router_back".}
proc routerForward*(router: ptr RouterT) {.cdecl, importc: "router_forward".}
proc routerGetByName*(name: cstring): ptr RouterT {.cdecl,
    importc: "router_get_by_name".}
proc routerGetVersion*(): cstring {.cdecl, importc: "router_get_version".}