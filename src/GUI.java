
import Tables.Patient;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.event.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public class GUI extends JFrame implements DialogClient {

    public int GUI_DISPLAY_LIMIT = 100;

    // Store the model as a vector of email buddies

    Connection databaseConnection;
    Statement stat;

    ArrayList<Patient> patientList = new ArrayList<Patient>();
    //ArrayList<FakepatientSong> songList = new ArrayList<FakepatientSong>();


    //private FakepatientSong selectedSong; //song currently selected in the GUI list
    private Patient selectedPatient; //patient currently selected in the GUI list

    //private FakepatientSong songBeingEdited; //song being edited in a dialog

    // Store the view that contains the components
    ListPanel view; //panel of GUI components for the main window
    GUI thisFrame;

    // Here are the component listeners
    ActionListener theSearchButtonListener;
    //ListSelectionListener songListSelectionListener;
    ListSelectionListener patientListSelectionListener;
    MouseListener doubleClickSongListListener;
    KeyListener keyListener;

    // Here is the default constructor
    public GUI(String title, Connection aDB, Statement aStatement, ArrayList<Patient> initialPatients) {
        super(title);
        databaseConnection = aDB;
        stat = aStatement;

        patientList = initialPatients;
        selectedPatient = null;
        thisFrame = this;

        addWindowListener(
                new WindowAdapter() {
                    public void windowClosing(WindowEvent e) {
                        try {
                            System.out.println("Closing Database Connection");
                            databaseConnection.close();
                        } catch (SQLException e1) {
                            // TODO Auto-generated catch block
                            e1.printStackTrace();
                        }
                        System.exit(0);
                    }
                }
        );


        // Make the main window view panel
        add(view = new ListPanel());

        // Add a listener for the add button
        theSearchButtonListener = new ActionListener() {
            public void actionPerformed(ActionEvent event) {
                if(event.getSource() instanceof JButton) {
                    if (((JButton) event.getSource()).getText().toLowerCase().equals("edit"))
                        edit_button();
                    else if (((JButton) event.getSource()).getText().toLowerCase().equals("new"))
                        new_button();
                }
            }
        };
        // Add a listener to allow selection of buddies from the list
        /*songListSelectionListener = new ListSelectionListener() {
            public void valueChanged(ListSelectionEvent event) {
                selectSong();
            }
        };*/
        // Add a listener to allow selection of buddies from the list
        patientListSelectionListener = new ListSelectionListener() {
            public void valueChanged(ListSelectionEvent event) {
                selectPatient();
            }
        };

        // Add a listener to allow double click selections from the list for editing
        doubleClickSongListListener = new MouseAdapter() {
            public void mouseClicked(MouseEvent event) {
                /*if (event.getClickCount() == 2) {
                    JList theList = (JList) event.getSource();
                    int index = theList.locationToIndex(event.getPoint());
                    songBeingEdited = (FakepatientSong) theList.getModel().getElementAt(index);
                    System.out.println("Double Click on: " + songBeingEdited);


                    SongDetailsDialog dialog = new SongDetailsDialog(thisFrame, thisFrame, "Song Details Dialog", true, songBeingEdited);
                    dialog.setVisible(true);
                }*/
                System.out.println("MOUSE CLICKED");
            }
        };

        keyListener = new KeyListener() {

            @Override
            public void keyPressed(KeyEvent arg0) {

            }

            @Override
            public void keyReleased(KeyEvent arg0) {

            }

            @Override
            public void keyTyped(KeyEvent arg0) {

                int keyChar = arg0.getKeyChar();

                if (keyChar == KeyEvent.VK_ENTER) edit_button();

            }
        };


        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setSize(600, 300);

        // Start off with everything updated properly to reflect the model state
        update();
    }

    // Enable all listeners
    private void enableListeners() {
        view.getEditButton().addActionListener(theSearchButtonListener);
        view.getNewButton().addActionListener(theSearchButtonListener);
        //view.getSaveButton().addActionListener(theSearchButtonListener);
        view.getPatientList().addListSelectionListener(patientListSelectionListener);

    }

    // Disable all listeners
    private void disableListeners() {
        view.getEditButton().removeActionListener(theSearchButtonListener);
        view.getNewButton().removeActionListener(theSearchButtonListener);
        //view.getSaveButton().removeActionListener(theSaveButtonListener);
        view.getPatientList().removeListSelectionListener(patientListSelectionListener);
    }

    private void new_button() {
        System.out.println("New");
        patientDialog(true);
    }
    // This is called when the user clicks the add button
    private void edit_button() {
        System.out.println("Edit");
        if (selectedPatient != null)
            patientDialog(false);
        else
            JOptionPane.showMessageDialog(null, "You must first select a patient to edit!", "No Patient Selected!", JOptionPane.INFORMATION_MESSAGE);
    }

    private void patientDialog(final Boolean newPatient){
        JPanel patient_frame = new JPanel();
        patient_frame.setLayout(new GridLayout(10, 2));

        JLabel label;

        label = new JLabel("First Name ");
        patient_frame.add(label);
        final JTextField fr_name = new JTextField();
        patient_frame.add(fr_name);

        label = new JLabel("Last Name ");
        patient_frame.add(label);
        final JTextField sc_name = new JTextField();
        patient_frame.add(sc_name);

        label = new JLabel("Street Address ");
        patient_frame.add(label);
        final JTextField address = new JTextField();
        patient_frame.add(address);

        label = new JLabel("City ");
        patient_frame.add(label);
        final JTextField city = new JTextField();
        patient_frame.add(city);

        label = new JLabel("Province (Example ON) ");
        patient_frame.add(label);
        final JTextField province = new JTextField();
        patient_frame.add(province);

        label = new JLabel("Primary Phone-Number ");
        patient_frame.add(label);
        final JTextField primary = new JTextField();
        patient_frame.add(primary);

        label = new JLabel("Secondary Phone-Number ");
        patient_frame.add(label);
        final JTextField secondary = new JTextField();
        patient_frame.add(secondary);

        label = new JLabel("Email ");
        patient_frame.add(label);
        final JTextField email = new JTextField();
        patient_frame.add(email);

        label = new JLabel("Occupation ");
        patient_frame.add(label);
        final JTextField occupation = new JTextField();
        patient_frame.add(occupation);

        label = new JLabel("Policy Number ");
        patient_frame.add(label);
        final JTextField policy = new JTextField();
        patient_frame.add(policy);

        final Patient readPatient = new Patient();
        if(!newPatient){

            if (selectedPatient.getId() != null)
                readPatient.setId(selectedPatient.getId());
            if (selectedPatient.getFirst() != null)
                fr_name.setText(selectedPatient.getFirst());
            if (selectedPatient.getLast() != null)
                sc_name.setText(selectedPatient.getLast());
            if (selectedPatient.getStreet() != null)
                address.setText(selectedPatient.getStreet());
            if (selectedPatient.getCity() != null)
                city.setText(selectedPatient.getCity());
            if (selectedPatient.getProvince() != null)
                province.setText(selectedPatient.getProvince());
            if (selectedPatient.getPhoneNumber() != null)
                primary.setText(selectedPatient.getPhoneNumber());
            if (selectedPatient.getPhoneNumber2() != null)
                secondary.setText(selectedPatient.getPhoneNumber2());
            if (selectedPatient.getEmail() != null)
                email.setText(selectedPatient.getEmail());
            if (selectedPatient.getOccupation() != null)
                occupation.setText(selectedPatient.getOccupation());
        }


        final JFrame patient_editor = new JFrame("");

        ActionListener internalListener = new ActionListener() {
            public void actionPerformed(ActionEvent event) {
                if (event.getSource() instanceof JButton)
                    if (((JButton) event.getSource()).getText().toLowerCase().equals("save")) {
                        System.out.println("Save");
                        String user_neglected = "";
                        if (fr_name.getText() != null && !fr_name.getText().equals(""))
                            readPatient.setFirst(fr_name.getText());
                        else
                            user_neglected += "first name, ";
                        if (sc_name.getText() != null && !sc_name.getText().equals(""))
                            readPatient.setLast(sc_name.getText());
                        if (address.getText() != null && !address.getText().equals(""))
                            readPatient.setStreet(address.getText());
                        if (city.getText() != null && !city.getText().equals(""))
                            readPatient.setCity(city.getText());
                        if (province.getText() != null && !province.getText().equals("") && province.getText().length() == 2)
                            readPatient.setProvince(province.getText());
                        else if (province.getText() != null && province.getText().length() != 2 && !province.getText().equals(""))
                            user_neglected += "proper province format (Example: ON), ";
                        else
                            user_neglected += "province, ";
                        if (primary.getText() != null && !primary.getText().equals(""))
                            readPatient.setPhoneNumber(primary.getText());
                        else
                            user_neglected+= "phone number, ";
                        if (secondary.getText() != null && !secondary.getText().equals(""))
                            readPatient.setPhoneNumber2(secondary.getText());
                        if (email.getText() != null && !email.getText().equals(""))
                            readPatient.setEmail(email.getText());
                        if (occupation.getText() != null && !occupation.getText().equals(""))
                            readPatient.setOccupation(occupation.getText());
                        if ( !user_neglected.equals("") )
                            JOptionPane.showMessageDialog(null, "Sorry, you neglected to enter: "+user_neglected, "Missing Info!", JOptionPane.INFORMATION_MESSAGE);
                        else {
                            if (newPatient) {
                                Patient newPatient = new Patient();
                                newPatient.copy(readPatient);
                                patientList.add(newPatient);
                            }else {
                                selectedPatient.copy(readPatient);
                            }
                            readPatient.databaseSave(databaseConnection);
                            updateList();
                            patient_editor.setVisible(false);
                        }
                    }
            }
        };

        JPanel buttonPanel = new JPanel();
        JButton saveButton = new JButton("Save");
        JButton prescButton = new JButton("Prescriptions");

        buttonPanel.add(saveButton,BorderLayout.EAST);
        buttonPanel.add(prescButton, BorderLayout.WEST);

        String title;
        if(newPatient)
            title="New Patient";
        else
            title="Edit Patient";
        patient_editor.setTitle(title);

        saveButton.addActionListener(internalListener);
        prescButton.addActionListener(internalListener);


        patient_editor.setSize(600, 400);
        patient_editor.add(patient_frame);
        patient_editor.add(buttonPanel, BorderLayout.AFTER_LAST_LINE);
        patient_editor.setVisible(true);
    }

    // This is called when the user clicks the edit button


    // This is called when the user selects a patient from the list
    private void selectPatient() {
        selectedPatient = (Patient) (view.getPatientList().getSelectedValue());
        if (selectedPatient != null)
            //System.out.println("patient Selected: " + selectedPatient);

        update();
    }

    // This is called when the user selects a song from the list
    private void selectSong() {
        /*
        selectedSong = (FakepatientSong) (view.getSongList().getSelectedValue());
        if (selectedSong != null)
            //System.out.println("Song Selected: " + selectedSong);
        */
        update();
    }


    // Update the remove button
    private void updateSearchButton() {
        view.getEditButton().setEnabled(true);
    }


    // Update the list
    private void updateList() {

        boolean foundSelected = false;

        Patient patientArray[] = new Patient[1]; //just to establish array type
        view.getPatientList().setListData(((Patient[]) patientList.toArray(patientArray)));

        //FakepatientSong songArray[] = new FakepatientSong[1]; //just to establish array type
        //view.getSongList().setListData(((FakepatientSong[]) songList.toArray(songArray)));

        if (selectedPatient != null)
            view.getPatientList().setSelectedValue(selectedPatient, true);
        //if (selectedSong != null)
        //    view.getSongList().setSelectedValue(selectedSong, true);
        //    view.getSongList().setSelectedValue(selectedSong, true);

    }

    // Update the components
    public void update() {
        disableListeners();
        updateList();
        updateSearchButton();
        enableListeners();
    }

    @Override
    public void dialogFinished(DialogClient.operation requestedOperation) {
        // TODO
        if (requestedOperation == DialogClient.operation.UPDATE) {
            //TO DO
            //update song data in database
            System.out.println("UPDATE");
        } else if (requestedOperation == DialogClient.operation.DELETE) {
            //TO DO
            //delete song from database
            System.out.println("DELETE:");
        }
        //songBeingEdited = null;
        update();
    }

    @Override
    public void dialogCancelled() {

        //songBeingEdited = null;
        update();

    }

}