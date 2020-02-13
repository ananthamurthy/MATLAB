// Copyright 2019 The MathWorks, Inc.
#ifndef NETWORK_WEBSOCKET_H
#define NETWORK_WEBSOCKET_H

#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>
#include <string>
#include <vector>
#include <iostream>
#include <memory>
#include <mutex>
#include <functional>

namespace Network
{
namespace WebSocket
{
class Client
{
private:
    static std::vector<std::shared_ptr<emscripten::val>> clientPtrs_;
    static std::mutex mu_;
    std::shared_ptr<emscripten::val> clientPtr_;
    enum ReadyStatus
    {
        CONNECTING,
        OPEN,
        CLOSING,
        CLOSED
    };

    auto static url(emscripten::val client) -> std::string;

public:
    Client(const std::string url);

    auto url(void) -> std::string;

    auto send(const std::string message) -> void;

    auto close(void) -> void;

    auto readyState(void) -> int;

    auto static remove(const std::string url) -> void;

    /* Callback */
    auto addEventListener(const std::string eventName, const std::string callbackFcnName) -> void;

    auto removeEventListener(const std::string eventName, const std::string callbackFcnName) -> void;
};

} // namespace WebSocket
} // namespace Network

#endif // NETWORK_WEBSOCKET_H