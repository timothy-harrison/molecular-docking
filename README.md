# Batch Running Vina Autodock w/ Pardaxin Variations made by FoldX

### Assumptions

You have autodock_vina and foldx installed and in your *PATH*. We also have assumptions based on the rigidity of ligands and receptors.

## Justification

Studying and performing the calculations by hand for 100's, potentially 1000's of different receptor variants is slow and cumbersome. The plan is to eventually get an environment set up so you can simply run:

` calculate ./path_to_ligand ./path_to_receptor ./path_to_output `

And then the program simply takes care of everything else.

> Potentially, the plan is to intercept the result to insert into a database for quick and easy reading. There is also potential to package this into a web sever for everyone to access.

## Step 1: Creating a PDB readable by FoldX

Using the shell script:

> ` foldx --command=PDBFile --pdb=pardaxin.pdb --pdb-dir=./pardaxin --output-dir=./pardaxin
>   mv ./pardaxin/PF_pardaxin.fxout ./pardaxin/PF_pardaxin.pdb`

The first line trandforms the pardaxin pdb into a foldx readable pdb. The second line simply renames it to a pdb.

The PF at the start distinguishes it from our original pdb. Additionally, the first command outputs a .fxout file, we just rename the type of the file.

From our example with pardaxin, we have created 418 different variants.

*TODO:* Find a setting to rename the outputted pdbs in to the convention ***residue-residuenumber-finalresidue_pardaxin.pdb*** for example; Gly 1 into Ala: *G1A_pardaxin.pdb*.

## Step 2: Convert the PDBs to PDBQT with Open Babel

With our new pdbs we now need to convert these into pdbqt files for autdock_vina to read.
