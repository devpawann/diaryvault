part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  final bool? newNote;
  final String id;
  final String? title;
  final String? hash;
  final QuillController? controller;
  final DateTime? createdAt;
  final List<NoteAssetModel>? allNoteAssets;
  final List<String>? tags;

  // tells if it is safe to access the properties of this state
  final bool safe;

  // required fields must be initalized only once, while creating new state copy the values for these
  // from old state only
  const NotesState({
    this.title,
    this.hash,
    this.createdAt,
    this.controller,
    this.newNote,
    this.allNoteAssets,
    this.tags,
    required this.id,
    required this.safe,
  });

  @override
  List<Object> get props => [id];
}

/// Initally DummyState will be emitted, then UI (can be both read or edit page) has to deicde
/// whether to load an existing note, or create a new note
class NoteDummyState extends NotesState {
  const NoteDummyState({required String id}) : super(id: id, safe: false);

  @override
  String toString() {
    return "NoteDummyState(id: ${this.id})";
  }
}

/// Initial state, when a new note is getting created, or an existing note is opened
/// It means a new note has been initialized, or an existing note has been loaded but they aren't edited yet
/// Useful for shpwing tick mark for saving in edit screen after the editing begind
class NoteInitialState extends NotesState {
  const NoteInitialState({
    required bool newNote,
    required QuillController controller,
    required DateTime createdAt,
    required String title,
    required List<NoteAssetModel> allNoteAssets,
    required String id,
    required String hash,
    required List<String> tags,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          hash: hash,
          title: title,
          createdAt: createdAt,
          allNoteAssets: allNoteAssets,
          safe: true,
          tags: tags,
        );

  @override
  String toString() {
    return "NoteInitialState(newNote: $newNote,createdAt: $createdAt, id: ${this.id}, title: $title, tags: $tags, hash: $hash,)";
  }
}

/// once the user starts editing, [NoteInitialState] changes to [NoteUpdatedState]
class NoteUpdatedState extends NotesState {
  const NoteUpdatedState({
    required bool newNote,
    required QuillController controller,
    required DateTime createdAt,
    required String title,
    required List<NoteAssetModel> allNoteAssets,
    required String id,
    required List<String> tags,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          allNoteAssets: allNoteAssets,
          safe: true,
          tags: tags,
        );

  @override
  List<Object> get props => [id, title!, createdAt!, allNoteAssets!, tags!];

  @override
  String toString() {
    return "NoteUpdatedState(newNote: $newNote,createdAt: $createdAt, id: ${this.id}, title: $title, allNoteAssets: $allNoteAssets)";
  }
}

// Loading state while fetching an existing note
class NoteFetchLoading extends NotesState {
  const NoteFetchLoading({
    bool? newNote,
    QuillController? controller,
    DateTime? createdAt,
    String? title,
    required String id,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          safe: false,
        );
}

class NoteFetchFailed extends NotesState {
  const NoteFetchFailed({
    bool? newNote,
    QuillController? controller,
    DateTime? createdAt,
    String? title,
    required String id,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          safe: false,
        );
}

//* Notes saving
class NoteSaveLoading extends NotesState {
  const NoteSaveLoading({
    required bool newNote,
    required QuillController controller,
    required DateTime createdAt,
    required String title,
    required List<NoteAssetModel> noteAssets,
    required String id,
    required List<String> tags,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          allNoteAssets: noteAssets,
          safe: true,
          tags: tags,
        );
}

class NoteSavedSuccesfully extends NotesState {
  const NoteSavedSuccesfully({
    required bool newNote,
    required QuillController controller,
    required DateTime createdAt,
    required String title,
    required List<NoteAssetModel> noteAssets,
    required String id,
    required List<String> tags,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          allNoteAssets: noteAssets,
          safe: true,
          tags: tags,
        );
}

class NotesSavingFailed extends NotesState {
  const NotesSavingFailed({
    required bool newNote,
    required QuillController controller,
    required DateTime createdAt,
    required String title,
    required List<NoteAssetModel> noteAssets,
    required String id,
    required List<String> tags,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          allNoteAssets: noteAssets,
          safe: true,
          tags: tags,
        );
}

class NoteAutoSavedSuccesfully extends NotesState {
  const NoteAutoSavedSuccesfully({
    required bool newNote,
    required QuillController controller,
    required DateTime createdAt,
    required String title,
    required List<NoteAssetModel> noteAssets,
    required String id,
    required List<String> tags,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          allNoteAssets: noteAssets,
          safe: true,
          tags: tags,
        );
}

class NotesAutoSavingFailed extends NotesState {
  const NotesAutoSavingFailed({
    required bool newNote,
    required QuillController controller,
    required DateTime createdAt,
    required String title,
    required List<NoteAssetModel> noteAssets,
    required String id,
    required List<String> tags,
  }) : super(
          newNote: newNote,
          controller: controller,
          id: id,
          title: title,
          createdAt: createdAt,
          allNoteAssets: noteAssets,
          safe: true,
          tags: tags,
        );
}

class NoteDeleteLoading extends NotesState {
  const NoteDeleteLoading({required String id}) : super(id: id, safe: false);
}

class NoteDeletionSuccesful extends NotesState {
  const NoteDeletionSuccesful({required String id})
      : super(id: id, safe: false);
}

class NoteDeletionFailed extends NotesState {
  const NoteDeletionFailed({required String id}) : super(id: id, safe: false);
}

class FetchAfterAutoSave extends NotesState {
  const FetchAfterAutoSave({required String id}) : super(id: id, safe: false);
}
