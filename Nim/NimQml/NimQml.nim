import NimQmlTypes
import tables

## NimQml aims to provide binding to the QML for the Nim programming language

export QObject
export QApplication
export QVariant
export QQmlApplicationEngine
export QQmlContext

type QMetaType* {.pure.} = enum ## \
  ## Qt metatypes values used for specifing the 
  ## signals and slots argument and return types.
  ##
  ## This enum mimic the QMetaType::Type C++ enum
  UnknownType = cint(0), 
  Bool = cint(1),
  Int = cint(2), 
  QString = cint(10), 
  VoidStar = cint(31),
  QVariant = cint(41), 
  Void = cint(43)

var qobjectRegistry = initTable[ptr QObjectObj, bool]()

proc debugMsg(message: string) = 
  echo "NimQml: ", message

proc debugMsg(typeName: string, procName: string) = 
  var message = typeName
  message &= ": "
  message &= procName
  debugMsg(message)

proc debugMsg(typeName: string, procName: string, userMessage: string) = 
  var message = typeName
  message &= ": "
  message &= procName
  message &= " "
  message &= userMessage
  debugMsg(message)

# QVariant
proc dos_qvariant_create(variant: var RawQVariant) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_create_int(variant: var RawQVariant, value: cint) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_create_bool(variant: var RawQVariant, value: bool) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_create_string(variant: var RawQVariant, value: cstring) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_create_qobject(variant: var RawQVariant, value: DynamicQObject) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_delete(variant: RawQVariant) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_isnull(variant: RawQVariant, isNull: var bool) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_toInt(variant: RawQVariant, value: var cint) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_toBool(variant: RawQVariant, value: var bool) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_toString(variant: RawQVariant, value: var cstring, length: var cint) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_setInt(variant: RawQVariant, value: cint) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_setBool(variant: RawQVariant, value: bool) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qvariant_setString(variant: RawQVariant, value: cstring) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_chararray_delete(rawCString: cstring) {.cdecl, dynlib:"libDOtherSide.so", importc.}

proc create*(variant: QVariant) =
  ## Create a new QVariant
  dos_qvariant_create(variant.data)
  variant.deleted = false

proc create*(variant: QVariant, value: cint) = 
  ## Create a new QVariant given a cint value
  dos_qvariant_create_int(variant.data, value)
  variant.deleted = false

proc create*(variant: QVariant, value: bool) =
  ## Create a new QVariant given a bool value  
  dos_qvariant_create_bool(variant.data, value)
  variant.deleted = false

proc create*(variant: QVariant, value: string) = 
  ## Create a new QVariant given a string value
  dos_qvariant_create_string(variant.data, value)
  variant.deleted = false

proc create*(variant: QVariant, value: QObject) =
  ## Create a new QVariant given a QObject
  dos_qvariant_create_qobject(variant.data, value.data)
  variant.deleted = false
  
proc delete*(variant: QVariant) = 
  ## Delete a QVariant
  if variant.deleted:
    return
  debugMsg("QVariant", "delete")
  dos_qvariant_delete(variant.data)
  variant.deleted = true

proc newQVariant*(): QVariant =
  ## Return a new QVariant  
  new(result, delete)
  result.create()

proc newQVariant*(value: cint): QVariant =
  new(result, delete)
  result.create(value)

proc newQVariant*(value: bool): QVariant  =
  new(result, delete)
  result.create(value)

proc newQVariant*(value: string): QVariant  =
  new(result, delete)
  result.create(value)

proc newQVariant*(value: QObject): QVariant  =
  new(result, delete)
  result.create(value)

proc newQVariant*(value: RawQVariant, takeOwnership: bool = false): QVariant =
  if takeOwnership:  
    new(result, delete)
    result.deleted = false
  else:
    new(result)
    result.deleted = true # Disable explicit delete
  result.data = value
  
proc isNull*(variant: QVariant): bool = 
  ## Return true if the QVariant value is null, false otherwise
  dos_qvariant_isnull(variant.data, result)

proc intVal*(variant: QVariant): int = 
  ## Return the QVariant value as int
  var rawValue: cint
  dos_qvariant_toInt(variant.data, rawValue)
  result = rawValue.cint

proc `intVal=`*(variant: QVariant, value: int) = 
  ## Sets the QVariant value int value
  var rawValue = value.cint
  dos_qvariant_setInt(variant.data, rawValue)

proc boolVal*(variant: QVariant): bool = 
  ## Return the QVariant value as bool
  dos_qvariant_toBool(variant.data, result)

proc `boolVal=`*(variant: QVariant, value: bool) =
  ## Sets the QVariant bool value
  dos_qvariant_setBool(variant.data, value)

proc stringVal*(variant: QVariant): string = 
  ## Return the QVariant value as string
  var rawCString: cstring
  var rawCStringLength: cint
  dos_qvariant_toString(variant.data, rawCString, rawCStringLength)
  result = $rawCString
  dos_chararray_delete(rawCString)

proc `stringVal=`*(variant: QVariant, value: string) = 
  ## Sets the QVariant string value
  dos_qvariant_setString(variant.data, value)


# QQmlApplicationEngine
proc dos_qqmlapplicationengine_create(engine: var QQmlApplicationEngine) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qqmlapplicationengine_load(engine: QQmlApplicationEngine, filename: cstring) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qqmlapplicationengine_context(engine: QQmlApplicationEngine, context: var QQmlContext) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qqmlapplicationengine_delete(engine: QQmlApplicationEngine) {.cdecl, dynlib:"libDOtherSide.so", importc.}

proc create*(engine: var QQmlApplicationEngine) = 
  ## Create an new QQmlApplicationEngine
  dos_qqmlapplicationengine_create(engine)

proc load*(engine: QQmlApplicationEngine, filename: cstring) = 
  ## Load the given Qml file 
  dos_qqmlapplicationengine_load(engine, filename)

proc rootContext*(engine: QQmlApplicationEngine): QQmlContext =
  ## Return the engine root context
  dos_qqmlapplicationengine_context(engine, result)

proc delete*(engine: QQmlApplicationEngine) = 
  ## Delete the given QQmlApplicationEngine
  debugMsg("QQmlApplicationEngine", "delete")
  dos_qqmlapplicationengine_delete(engine)

# QQmlContext
proc dos_qqmlcontext_setcontextproperty(context: QQmlContext, propertyName: cstring, propertyValue: RawQVariant) {.cdecl, dynlib:"libDOtherSide.so", importc.}

proc setContextProperty*(context: QQmlContext, propertyName: string, propertyValue: QVariant) = 
  ## Sets a new property with the given value
  dos_qqmlcontext_setcontextproperty(context, propertyName, propertyValue.data)

# QApplication
proc dos_qguiapplication_create() {.cdecl, dynlib: "libDOtherSide.so", importc.}
proc dos_qguiapplication_exec() {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qguiapplication_delete() {.cdecl, dynlib:"libDOtherSide.so", importc.}

proc create*(application: QApplication) = 
  ## Create a new QApplication
  dos_qguiapplication_create()

proc exec*(application: QApplication) =
  ## Start the Qt event loop
  dos_qguiapplication_exec()

proc delete*(application: QApplication) = 
  ## Delete the given QApplication
  dos_qguiapplication_delete()

# QObject
type RawQVariantArray {.unchecked.} = array[0..0, RawQVariant]
type RawQVariantArrayPtr = ptr RawQVariantArray

proc toVariantSeq(args: RawQVariantArrayPtr, numArgs: cint): seq[QVariant] =
  result = @[]
  for i in 0..numArgs-1:
    result.add(newQVariant(args[i]))

proc toCIntSeq(metaTypes: openarray[QMetaType]): seq[cint] =
  result = @[]
  for metaType in metaTypes:
    result.add(cint(metaType))

type QObjectCallBack = proc(nimobject: ptr QObjectObj, slotName: RawQVariant, numArguments: cint, arguments: RawQVariantArrayPtr) {.cdecl.}
    
proc dos_qobject_create(qobject: var DynamicQObject, nimobject: ptr QObjectObj, qobjectCallback: QObjectCallBack) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qobject_delete(qobject: DynamicQObject) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qobject_slot_create(qobject: DynamicQObject, slotName: cstring, argumentsCount: cint, argumentsMetaTypes: ptr cint, slotIndex: var cint) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qobject_signal_create(qobject: DynamicQObject, signalName: cstring, argumentsCount: cint, argumentsMetaTypes: ptr cint, signalIndex: var cint) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qobject_signal_emit(qobject: DynamicQObject, signalName: cstring, argumentsCount: cint, arguments: ptr QVariant) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qobject_property_create(qobject: DynamicQObject, propertyName: cstring, propertyType: cint, readSlot: cstring, writeSlot: cstring, notifySignal: cstring) {.cdecl, dynlib:"libDOtherSide.so", importc.}

method onSlotCalled*(nimobject: QObject, slotName: string, args: openarray[QVariant]) =
  ## Called from the NimQml bridge when a slot is called from Qml.
  ## Subclasses can override the given method for handling the slot call
  discard()

proc qobjectCallback(nimObject: ptr QObjectObj, slotName: RawQVariant, numArguments: cint, arguments: RawQVariantArrayPtr) {.cdecl, exportc.} =
  if not qobjectRegistry[nimObject]:
    return 
  let qobject = cast[QObject](nimObject)
  GC_ref(qobject)
  qobject.onSlotCalled(newQVariant(slotName).stringVal, arguments.toVariantSeq(numArguments))
  GC_unref(qobject)

proc create*(qobject: QObject) =
  ## Create a new QObject
  debugMsg("QObject", "create")
  let qobjectPtr = addr(qobject[])
  qobjectRegistry[qobjectPtr] = true
  qobject.name = "QObject"
  qobject.deleted = false
  qobject.slots = initTable[string,cint]()
  qobject.signals = initTable[string, cint]()
  dos_qobject_create(qobject.data, qobjectPtr, qobjectCallback)
  
proc delete*(qobject: QObject) = 
  ## Delete the given QObject
  if qobject.deleted:
    return
  debugMsg("QObject", "delete")
  let qobjectPtr = addr(qobject[])
  qobjectRegistry.del qobjectPtr
  dos_qobject_delete(qobject.data)
  qobject.deleted = true
  
proc newQObject*(): QObject =
  new(result, delete)
  result.create()

proc registerSlot*(qobject: QObject,
                   slotName: string, 
                   metaTypes: openarray[QMetaType]) =
  ## Register a slot in the QObject with the given name and signature
  # Copy the metatypes array
  var copy = toCIntSeq(metatypes)
  var index: cint 
  dos_qobject_slot_create(qobject.data, slotName, cint(copy.len), addr(copy[0].cint), index)
  qobject.slots[slotName] = index

proc registerSignal*(qobject: QObject,
                     signalName: string, 
                     metatypes: openarray[QMetaType]) =
  ## Register a signal in the QObject with the given name and signature
  var index: cint 
  if metatypes.len > 0:
    var copy = toCIntSeq(metatypes)
    dos_qobject_signal_create(qobject.data, signalName, copy.len.cint, addr(copy[0].cint), index)
  else:
    dos_qobject_signal_create(qobject.data, signalName, 0, nil, index)
  qobject.signals[signalName] = index

proc registerProperty*(qobject: QObject,
                       propertyName: string, 
                       propertyType: QMetaType, 
                       readSlot: string, 
                       writeSlot: string, 
                       notifySignal: string) =
  ## Register a property in the QObject with the given name and type.
  dos_qobject_property_create(qobject.data, propertyName, propertyType.cint, readSlot, writeSlot, notifySignal)

proc emit*(qobject: QObject, signalName: string, args: openarray[QVariant] = []) =
  ## Emit the signal with the given name and values
  if args.len > 0: 
    var copy = @args
    dos_qobject_signal_emit(qobject.data, signalName, args.len.cint, addr(copy[0]))
  else:
    dos_qobject_signal_emit(qobject.data, signalName, 0, nil)

# QQuickView
proc dos_qquickview_create(view: var QQuickView) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qquickview_delete(view: QQuickView) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qquickview_show(view: QQuickView) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qquickview_source(view: QQuickView, filename: var cstring, length: var int) {.cdecl, dynlib:"libDOtherSide.so", importc.}
proc dos_qquickview_set_source(view: QQuickView, filename: cstring) {.cdecl, dynlib:"libDOtherSide.so", importc.}

proc create(view: var QQuickView) =
  ## Create a new QQuickView
  dos_qquickview_create(view)

proc source(view: QQuickView): cstring = 
  ## Return the source Qml file loaded by the view
  var length: int
  dos_qquickview_source(view, result, length)

proc `source=`(view: QQuickView, filename: cstring) =
  ## Sets the source Qml file laoded by the view
  dos_qquickview_set_source(view, filename)

proc show(view: QQuickView) = 
  ## Sets the view visible 
  dos_qquickview_show(view)

proc delete(view: QQuickView) =
  ## Delete the given QQuickView
  dos_qquickview_delete(view)

