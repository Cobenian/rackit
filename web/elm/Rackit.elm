module Rackit where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import StartApp
import Signal exposing (Address)
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)

type alias DeviceJson =
    { id : Int
    , name : String
    , device_type : String
    , data_center : String
    , power_in_use : Int
    , power_empty : Int
    , power_bad : Int
    , drives_in_use : Int
    , drives_empty : Int
    , drives_bad : Int
    , ports_in_use : Int
    , ports_empty : Int
    , ports_bad : Int
    }

type DeviceType =
  Server
  | Router
  | Switch
  | PDU

type alias Model =
  {
    deviceStatuses: List DeviceStatus
  }

type alias DeviceStatus =
  {
    name: String,
    power: ItemStatus,
    drives: ItemStatus,
    ports: ItemStatus,
    dataCenter: DataCenter,
    category: DeviceType
  }

type alias ItemStatus =
  {
    inUseCount: Int,
    emptyCount: Int,
    badCount: Int
  }

type alias DataCenter = String

initialModel : Model
initialModel =
  {
    deviceStatuses =
      [
        {
          name        = "switch-1",
          power       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          drives      = { inUseCount = 4, emptyCount = 0, badCount = 1 },
          ports       = { inUseCount = 48, emptyCount = 2, badCount = 0 },
          dataCenter  = "NYC",
          category    = Switch
        },
        {
          name        = "switch-2",
          power       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          drives      = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          ports       = { inUseCount = 50, emptyCount = 0, badCount = 0 },
          dataCenter  = "NYC",
          category    = Switch
        },
        {
          name        = "switch-3",
          power       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          drives      = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          ports       = { inUseCount = 24, emptyCount = 24, badCount = 0 },
          dataCenter  = "NYC",
          category    = Switch
        },
        {
          name        = "db-server-prod",
          power       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          drives      = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          ports       = { inUseCount = 4, emptyCount = 8, badCount = 0 },
          dataCenter  = "NYC",
          category    = Server
        },
        {
          name        = "db2-server-prod",
          power       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          drives      = { inUseCount = 0, emptyCount = 2, badCount = 0 },
          ports       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          dataCenter  = "SF",
          category    = Server
        },
        {
          name        = "db3-server-prod",
          power       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          drives      = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          ports       = { inUseCount = 4, emptyCount = 2, badCount = 0 },
          dataCenter  = "SF",
          category    = Server
        }
      ]
  }

type Action
  = NoOp

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

itemElement : String -> Int -> Html
itemElement itemClass itemCount =
  if itemCount > 0 then
    span [class ("label " ++ itemClass ++ " item-status")] [text (toString itemCount)]
  else
    text ""

itemStatus : ItemStatus -> List Html
itemStatus itemStatus =
  let
    a = itemElement "label-success" itemStatus.inUseCount
    b = itemElement "label-default" itemStatus.emptyCount
    c = itemElement "label-warning" itemStatus.badCount
  in
    [a,b,c]


category : DeviceStatus -> String
category deviceStatus =
  case deviceStatus.category of
    Server ->
      "Server"

    Router ->
      "Router"

    Switch ->
      "Switch"

    PDU ->
      "PDU"

errorClass : DeviceStatus -> String
errorClass deviceStatus =
  if deviceStatus.power.badCount > 0
    || deviceStatus.drives.badCount > 0
    || deviceStatus.ports.badCount > 0
    then
      "warning"
    else
      ""


deviceStatusItem : Address Action -> DeviceStatus -> Html
deviceStatusItem address deviceStatus =
  tr
    [ errorClass deviceStatus |> class ]
    [ td [class "name"] [ text deviceStatus.name ],
      td [class "category"] [ text (category deviceStatus)],
      td [class "data-center"] [ text deviceStatus.dataCenter ],
      td [class "power"] (itemStatus deviceStatus.power),
      td [class "drives"] (itemStatus deviceStatus.drives),
      td [class "ports"] (itemStatus deviceStatus.ports)
    ]

deviceList : Address Action -> List DeviceStatus -> Html
deviceList address deviceStatuses =
  let
    items = List.map (deviceStatusItem address) deviceStatuses
  in
    table
      [class "table table-striped table-hover"]
      [
        thead []
        [
          tr []
            [
              th [] [text "Name"],
              th [] [text "Type"],
              th [] [text "Data Center"],
              th [] [text "Power"],
              th [] [text "Drives"],
              th [] [text "Ports"]
            ]
        ]
        ,
        tbody [] items
      ]

-- lookupDevices : String -> Task Http.Error (List String)
-- lookupDevices query =
--     Http.get devices ("http://localhost:4000/devices")


-- devices : Json.Decoder DeviceJson
-- devices =
--   let
--     device = Json.object3 DeviceJson
--           ("name" := Json.string)
--           ("device_type" := Json.string)
--           ("data_center" := Json.string)
--     power = Json.object3 DeviceJson
--           ("power_in_use" := Json.int)
--           ("power_empty" := Json.int)
--           ("power_bad" := Json.int)
--     drives = Json.object3 DeviceJson
--           ("drives_in_use" := Json.int)
--           ("drives_empty" := Json.int)
--           ("drives_bad" := Json.int)
--     ports = Json.object3 DeviceJson
--           ("ports_in_use" := Json.int)
--           ("ports_empty" := Json.int)
--           ("ports_bad" := Json.int)
--   in
--       "devices" := Json.list device

view : Address Action -> Model -> Html
view address model =
  div [ id "container" ]
    [
      deviceList address model.deviceStatuses
    ]

main : Signal Html
main =
  StartApp.start
  { model = initialModel,
    view = view,
    update = update
  }
