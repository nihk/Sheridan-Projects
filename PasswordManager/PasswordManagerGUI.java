/*
Nick Rose
Java 2 - Project - Password Manager - April 14th, 2015
*/

import javax.swing.*;
import javax.swing.BorderFactory.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;
import java.util.Arrays;

public class PasswordManagerGUI extends JFrame {
	private JPanel superPanel, p1, p1north, p1center, p1south,
		p2, p2north, p2center;
	private JFileChooser chooseFile;
	private JTextField appendUsername, appendPassword, search,
		appendAccount;
	private JPasswordField enterProgramPassword;
	private JLabel enterProgramPasswordLabel, appendUsernameLabel,
		appendPasswordLabel, searchLabel, searchResultsLabel,
		emptyLabel1, emptyLabel2, emptyLabel3, emptyLabel4,
		appendAccountLabel, emptyLabel5;
	private JButton submitPassword, openFile,
		displayFile, encryptFile, decryptFile,
		appendToFile, searchFile, clearFileContents, clearSearchContents;
	private JTextArea fileContents, searchOutput;
	private JScrollPane fileScroller, searchScroller;
	private JFileChooser fileChooser;
	private File file, file2;
	private FileReader fr;
	private BufferedReader br;
	private FileWriter fw;
	private PrintWriter pw;
	private String password, read;
	private boolean canUseProgram, encryptedOnce, decryptedOnce;

	public PasswordManagerGUI() {
		initializer();
		setPanels();
		setColors();
		setSize(860, 568);
		setTitle("Nick Rose - Password Manager");
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
	}
	//initializes all the objects and sometimes gives sizes/alignment/font
	public void initializer() {
		superPanel = new JPanel(new BorderLayout(10, 10));
		p1 = new JPanel(new BorderLayout());
		p1north = new JPanel(new GridLayout(0, 2, 10, 10));
		p1center = new JPanel();
		p1south = new JPanel(new GridLayout(0, 2, 10, 10));
		p2 = new JPanel(new BorderLayout());
		p2north = new JPanel(new GridLayout(0, 2, 0, 10));
		p2center = new JPanel();

		enterProgramPassword = new JPasswordField(10);
		enterProgramPassword.setEchoChar('*');
		appendAccount = new JTextField(15);
		appendUsername = new JTextField(15);
		appendPassword = new JTextField(15);
		search = new JTextField(15);
		enterProgramPasswordLabel = new JLabel("Enter program password:");
		enterProgramPasswordLabel.setHorizontalAlignment(SwingConstants.CENTER);
		appendAccountLabel = new JLabel("Account to append:");
		appendAccountLabel.setHorizontalAlignment(SwingConstants.CENTER);
		appendUsernameLabel = new JLabel("Username to append:");
		appendUsernameLabel.setHorizontalAlignment(SwingConstants.CENTER);
		appendPasswordLabel = new JLabel("Password to append:");
		appendPasswordLabel.setHorizontalAlignment(SwingConstants.CENTER);
		searchLabel = new JLabel("Search file's contents:");
		searchLabel.setHorizontalAlignment(SwingConstants.CENTER);
		searchResultsLabel = new JLabel("Search results");
		searchResultsLabel.setHorizontalAlignment(SwingConstants.LEFT);
		emptyLabel1 = new JLabel("");
		emptyLabel2 = new JLabel("");
		emptyLabel2.setHorizontalAlignment(SwingConstants.CENTER);
		Font font2 = new Font("SansSerif", Font.BOLD + Font.ITALIC, 11);
		emptyLabel2.setFont(font2);
		emptyLabel2.setForeground(Color.red);
		emptyLabel3 = new JLabel("");
		emptyLabel3.setHorizontalAlignment(SwingConstants.CENTER);
		emptyLabel3.setFont(font2);
		emptyLabel3.setForeground(Color.red);
		emptyLabel4 = new JLabel("");
		emptyLabel5 = new JLabel("");
		emptyLabel4.setPreferredSize(emptyLabel4.getPreferredSize());
		emptyLabel3.setPreferredSize(emptyLabel3.getPreferredSize());
		emptyLabel2.setPreferredSize(emptyLabel2.getPreferredSize());
		Font font = new Font("SansSerif", Font.BOLD + Font.ITALIC, 13);
		emptyLabel4.setFont(font);
		emptyLabel4.setHorizontalAlignment(SwingConstants.CENTER);
		submitPassword = new JButton("Submit password");
		openFile = new JButton("Open file");
		displayFile = new JButton("Display file");
		encryptFile = new JButton("Encrypt file");
		decryptFile = new JButton("Decrypt file");
		appendToFile = new JButton("Append to file");
		searchFile = new JButton("Search");
		clearFileContents = new JButton("Clear console");
		clearSearchContents = new JButton("Clear search results");
		fileContents = new JTextArea(20, 35);
		fileContents.setEditable(false);
		searchOutput = new JTextArea(14, 34);
		searchOutput.setEditable(false);
		fileScroller = new JScrollPane(fileContents);
		searchScroller = new JScrollPane(searchOutput);
		fileChooser = new JFileChooser("C:\\Users\\Nick\\Desktop\\Sheridan\\Java 2\\Programs");
		canUseProgram = false;
		password = "";

		JButton[] buttonArray = {submitPassword, openFile,
		displayFile, encryptFile, decryptFile,
		appendToFile, searchFile, clearFileContents, clearSearchContents};
		for (int i = 0; i < buttonArray.length; i++) {
			buttonArray[i].addActionListener(new ButtonListener());
		}
	}
	//adds the GUI objects to appropriate panels
	public void setPanels() {
		p1north.add(enterProgramPasswordLabel);
		p1north.add(enterProgramPassword);
		p1north.add(emptyLabel1);
		p1north.add(submitPassword);
		p1north.add(openFile);
		p1north.add(displayFile);
		p1north.add(emptyLabel4);
		p1north.add(clearFileContents);
		p1center.add(fileScroller);
		p1south.add(encryptFile);
		p1south.add(decryptFile);
		p1.add(p1north, BorderLayout.NORTH);
		p1.add(p1center, BorderLayout.CENTER);
		p1.add(p1south, BorderLayout.SOUTH);

		p2north.add(appendAccountLabel);
		p2north.add(appendAccount);
		p2north.add(appendUsernameLabel);
		p2north.add(appendUsername);
		p2north.add(appendPasswordLabel);
		p2north.add(appendPassword);
		p2north.add(emptyLabel2);
		p2north.add(appendToFile);
		p2north.add(searchLabel);
		p2north.add(search);
		p2north.add(emptyLabel3);
		p2north.add(searchFile);
		p2north.add(emptyLabel5);
		p2north.add(clearSearchContents);
		p2center.add(searchResultsLabel);
		p2center.add(searchScroller);

		p2.add(p2north, BorderLayout.NORTH);
		p2.add(p2center, BorderLayout.CENTER);

		superPanel.add(p1, BorderLayout.WEST);
		superPanel.add(p2, BorderLayout.CENTER);
		add(superPanel);
	}
	//adds colors to panels/objects
	public void setColors() {
		superPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
		p1.setBorder(BorderFactory.createLineBorder(new Color(239, 236, 202), 5));
		p2.setBorder(BorderFactory.createLineBorder(new Color(239, 236, 202), 5));
		superPanel.setBackground(new Color(209, 219, 189));
		p1north.setBackground(new Color(239, 236, 202));
		p1center.setBackground(new Color(239, 236, 202));
		p1south.setBackground(new Color(239, 236, 202));
		p2north.setBackground(new Color(239, 236, 202));
		p2center.setBackground(new Color(239, 236, 202));

		JButton[] buttonArray = {submitPassword, openFile,
		displayFile, encryptFile, decryptFile,
		appendToFile, searchFile, clearFileContents, clearSearchContents};
		for (int i = 0; i < buttonArray.length; i++) {
			buttonArray[i].setBackground(new Color(238, 239, 247));
		}
	}
	public static void main(String[] args) {
		PasswordManagerGUI lt = new PasswordManagerGUI();
	}
	private class ButtonListener extends Encrypt implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			//set password based on the externally encrypted file, pw.txt, located in the same folder as this java file
			if (e.getSource() == submitPassword) {
				try {
					file2 = new File("pw.txt");
					fr = new FileReader(file2);
					br = new BufferedReader(fr);
					read = null;
					while ((read = br.readLine()) != null) {
						password = decryptLine(read);
					}
					br.close();
					file2 = null;
				} catch (IOException ioe) {
					System.exit(1);
				}
			}
			//can use the program match
			if (Arrays.equals(enterProgramPassword.getPassword(), password.toCharArray()) &&
				e.getSource() == submitPassword && !canUseProgram) {
				fileContents.setText("> Access granted.\n\n");
				canUseProgram = true;
			}
			//within this is every other button's intended action, only accessible if the password was correct
			if (Arrays.equals(enterProgramPassword.getPassword(), password.toCharArray()) && canUseProgram) {
				if (e.getSource() == openFile) {
					fileChooser.showOpenDialog(null);
					if (fileChooser.getSelectedFile() != null) {
						file = fileChooser.getSelectedFile();
						emptyLabel4.setText(file.getName());
					}
				}
				//display file contents in the fileContents textarea
				if (e.getSource() == displayFile) {
					if (file == null) {
						fileContents.append("> Please open a file first.\n\n");
					} else {
						try {
							fr = new FileReader(file);
							br = new BufferedReader(fr);
							read = null;
							while ((read = br.readLine()) != null) {
								fileContents.append(read + "\n");
							}
							fileContents.append("\n");
							br.close();
						} catch (IOException ioe) {
							System.exit(1);
						}
					}
				}
				//clear fileContents/searchOutput textareas
				if (e.getSource() == clearFileContents) {
					fileContents.setText("");
				}
				if (e.getSource() == clearSearchContents) {
					searchOutput.setText("");
				}
				//append passwords to the open file
				if (e.getSource() == appendToFile) {
					if (file == null) {
						emptyLabel2.setText("Please open a file first");
					} else if ((appendAccount.getText().length() > 0) && (appendUsername.getText().length() > 0) &&
						(appendPassword.getText().length() > 0)) {
						String concatAppends = appendAccount.getText() + " username: " + appendUsername.getText() +
							", password: " + appendPassword.getText();
						try {
							fw = new FileWriter(file, true);
							pw = new PrintWriter(fw);
							pw.println(concatAppends);
							pw.close();
							fileContents.append("> New password entry successfully added to " + file.getName() + "!\n\n");
						} catch (IOException ioe) {
							System.exit(1);
						}
						emptyLabel2.setText("");
						appendAccount.setText("");
						appendUsername.setText("");
						appendPassword.setText("");
					} else {
						emptyLabel2.setText("Please fill in all fields");
					}
				}
				//search the contents of the open file
				if (e.getSource() == searchFile) {
					if (file == null) {
						emptyLabel3.setText("Please open a file first");
					} else if (search.getText().length() == 0) {
						emptyLabel3.setText("Please enter a search term");
					} else {
						emptyLabel3.setText("");
						String searchTerm = search.getText().toLowerCase();
						boolean foundAMatch = false;
						searchOutput.setText("");
						try {
							fr = new FileReader(file);
							br = new BufferedReader(fr);
							read = null;
							while ((read = br.readLine()) != null) {
								if (read.toLowerCase().contains(searchTerm)) {
									searchOutput.append(read + "\n");
									foundAMatch = true;
								}
							}
							br.close();
						} catch (IOException ioe) {
							System.exit(1);
						}
						if (!foundAMatch) {
							searchOutput.setText("No matching search results.");
						}
					}
				}
				//encrypt the open file
				if (e.getSource() == encryptFile) {
					if (!encryptedOnce) {
						if (file == null) {
							fileContents.append("> Please open a file first.\n\n");
						} else {
							try {
								File temp = new File("temp.txt");
								fr = new FileReader(file);
								br = new BufferedReader(fr);
								fw = new FileWriter(temp);
								pw = new PrintWriter(fw);
								read = null;
								while ((read = br.readLine()) != null) {
									writeEncryption(encryptLine(read), pw);
								}
								pw.close();
								br.close();
								String originalName = file.getAbsolutePath();
								file.delete();
								temp.renameTo(new File(originalName));
								fileContents.append("> Encryption successful!\n\n");
								encryptedOnce = true;
								decryptedOnce = false;
							} catch (IOException ioe) {
								System.exit(1);
							}
						}
					} else {
						fileContents.append("> File is already encrypted!\n\n");
					}
				}
				//decrypt the open file; should only to be used after file is encrypted
				if (e.getSource() == decryptFile) {
					if (!decryptedOnce) {
						if (file == null) {
							fileContents.append("> Please open a file first.\n\n");
						} else {
							try {
								File temp = new File("temp.txt");
								fr = new FileReader(file);
								br = new BufferedReader(fr);
								fw = new FileWriter(temp);
								pw = new PrintWriter(fw);
								read = null;
								while ((read = br.readLine()) != null) {
									writeDecryption(decryptLine(read), pw);
								}
								pw.close();
								br.close();
								String originalName = file.getAbsolutePath();
								file.delete();
								temp.renameTo(new File(originalName));
								fileContents.append("> Decryption successful!\n\n");
								encryptedOnce = false;
								decryptedOnce = true;
							} catch (IOException ioe) {
								System.exit(1);
							}
						}
					} else {
						fileContents.append("> File is already decrypted!\n\n");
					}
				}
			} else { //if the password is incorrect, this error msg is prompted.
				fileContents.setText("> Please input a valid program password first.");
				canUseProgram = false;
			}
		}
	}
}