print maxFilePath; 

explorer = SceneExplorerManager.GetActiveExplorer(); -- get active explorer reference
selectedItems = explorer.SelectedItems(); -- get array of selected items

objClass = ObjExp; -- format of exported file is .obj

-- get objects of type Layer from all selected objects
selectedLayers = for s in selectedItems where (ClassOf s == Base_LayerBase_Layer) collect s;

isFirst = true; -- is first layer flag

max select none; -- reset current selection			 

-- for each buffered selected layer
for l in selectedLayers do							 
(	
	l.select true; -- select layer
	-- prepare output file path as concatenation of current model folder and layer name
	filePath = maxFilePath + l.name;                 

	print filePath; -- display output file for debug
	
	-- the export of first layer run with standart *.OBJ export configuration dialog	
	if isFirst then
	(
		exportFile filePath selectedOnly:on using:objClass
	)
	else
	(
		exportFile filePath #noprompt selectedOnly:on using:objClass
	)	
	
	l.select false; -- deselect layer
	isFirst = false; -- reset configuration`s flag and execute another exports with same settings as first export
)