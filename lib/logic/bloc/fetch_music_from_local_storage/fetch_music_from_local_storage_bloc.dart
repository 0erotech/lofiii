import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lofiii/data/services/storage_permission_service.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

part 'fetch_music_from_local_storage_event.dart';
part 'fetch_music_from_local_storage_state.dart';

class FetchMusicFromLocalStorageBloc extends Bloc<
    FetchMusicFromLocalStorageEvent, FetchMusicFromLocalStorageState> {
  final OnAudioQuery audioQuery;

  FetchMusicFromLocalStorageBloc({required this.audioQuery})
      : super(FetchMusicFromLocalStorageInitial()) {
    on<FetchMusicFromLocalStorageInitializationEvent>(
        _fetchMusicFromLocalStorageInitializationEvent);
  }

  FutureOr<void> _fetchMusicFromLocalStorageInitializationEvent(
      FetchMusicFromLocalStorageInitializationEvent event,
      Emitter<FetchMusicFromLocalStorageState> emit) async {
    try {
      // Check if storage permission is granted
      if (await StoragePermissionService.storagePermission()) {
        emit(FetchMusicFromLocalStorageLoadingState());

        Future<List<SongModel>> musicList = audioQuery.querySongs();

        // Emit success state with updated music list
        emit(FetchMusicFromLocalStorageSuccessState(musicsList:musicList));
      } else {
        await StoragePermissionService.storagePermission();
      }
    } catch (e) {
      // Handle any errors that occur during the process
      emit(
          FetchMusicFromLocalStorageFailureState(failureMessage: e.toString()));
    }
  }
}